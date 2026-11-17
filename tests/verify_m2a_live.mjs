// tests/verify_m2a_live.mjs
// Automated live Supabase PostgREST RLS and latency verification runner
// Usage: node tests/verify_m2a_live.mjs [SUPABASE_URL] [SUPABASE_ANON_KEY]
// Or set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY in .env.local

import fs from 'node:fs';
import path from 'node:path';

// Load .env.local if present
const envLocalPath = path.join(process.cwd(), '.env.local');
if (fs.existsSync(envLocalPath)) {
  const envContent = fs.readFileSync(envLocalPath, 'utf8');
  for (const line of envContent.split('\n')) {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('#') && trimmed.includes('=')) {
      const [key, ...rest] = trimmed.split('=');
      const val = rest.join('=').trim().replace(/^["']|["']$/g, '');
      process.env[key.trim()] = val;
    }
  }
}

const supabaseUrl = process.argv[2] || process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
const anonKey = process.argv[3] || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !anonKey) {
  console.log('------------------------------------------------------------');
  console.log('LIVE SUPABASE VERIFICATION RUNNER');
  console.log('------------------------------------------------------------');
  console.log('Status: Awaiting Supabase Development Project Credentials.');
  console.log('To run this test against a live Supabase instance:');
  console.log('  node tests/verify_m2a_live.mjs <SUPABASE_URL> <SUPABASE_ANON_KEY>');
  console.log('Or configure .env.local with:');
  console.log('  NEXT_PUBLIC_SUPABASE_URL=https://<project-ref>.supabase.co');
  console.log('  NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon-key>');
  process.exit(0);
}

const headers = {
  apikey: anonKey,
  Authorization: `Bearer ${anonKey}`,
  'Content-Type': 'application/json',
};

let passed = 0;
let failed = 0;

async function runTest(name, fn) {
  try {
    const start = performance.now();
    await fn();
    const duration = (performance.now() - start).toFixed(1);
    console.log(`[PASS] ${name} (${duration}ms)`);
    passed++;
  } catch (err) {
    console.error(`[FAIL] ${name}: ${err.message}`);
    failed++;
  }
}

async function fetchJson(endpoint, options = {}) {
  const res = await fetch(`${supabaseUrl}/rest/v1${endpoint}`, {
    ...options,
    headers: { ...headers, ...options.headers },
  });
  return { status: res.status, data: res.status !== 204 ? await res.json().catch(() => null) : null };
}

console.log('============================================================');
console.log(`Testing Live Supabase PostgREST API at: ${supabaseUrl}`);
console.log('============================================================');

// 1. Measure Roundtrip Latency
const pingStart = performance.now();
await fetch(`${supabaseUrl}/rest/v1/scenarios?select=count`, { headers });
const pingMs = (performance.now() - pingStart).toFixed(1);
console.log(`Empirical HTTP round-trip latency to endpoint: ${pingMs}ms\n`);

// 2. Positive Read: Published Scenarios
await runTest('Positive Read: Anonymous can fetch published scenario', async () => {
  const res = await fetchJson('/scenarios?status=eq.published&select=slug,status');
  if (res.status !== 200 || !Array.isArray(res.data) || res.data.length !== 1) {
    throw new Error(`Expected 1 published scenario, got status ${res.status}, count ${res.data?.length}`);
  }
  if (res.data[0].slug !== 'telegram-messenger-takeover') {
    throw new Error(`Unexpected published scenario slug: ${res.data[0].slug}`);
  }
});

// 3. Positive Read: Published Scenario Child Steps
await runTest('Positive Read: Anonymous can fetch child steps for published scenario', async () => {
  const res = await fetchJson('/scenario_steps?scenario_id=eq.c0000000-0000-4000-8000-000000000001&select=step_key,order_index');
  if (res.status !== 200 || !Array.isArray(res.data) || res.data.length !== 4) {
    throw new Error(`Expected 4 steps, got status ${res.status}, count ${res.data?.length}`);
  }
});

// 4. Negative Read: Draft Scenario Isolation
await runTest('Negative Read: Anonymous CANNOT read draft scenarios (returns 0 rows)', async () => {
  const res = await fetchJson('/scenarios?id=eq.c0000000-0000-4000-8000-000000000005');
  if (res.status !== 200 || !Array.isArray(res.data) || res.data.length !== 0) {
    throw new Error(`Expected 0 rows for draft scenario, got count ${res.data?.length}`);
  }
});

// 5. Negative Read: Archived Scenario Isolation
await runTest('Negative Read: Anonymous CANNOT read archived scenarios (returns 0 rows)', async () => {
  const res = await fetchJson('/scenarios?id=eq.c0000000-0000-4000-8000-000000000006');
  if (res.status !== 200 || !Array.isArray(res.data) || res.data.length !== 0) {
    throw new Error(`Expected 0 rows for archived scenario, got count ${res.data?.length}`);
  }
});

// 6. Negative Read: Child Step Isolation on Draft
await runTest('Negative Read: Anonymous CANNOT access child steps of draft scenario (returns 0 rows)', async () => {
  const res = await fetchJson('/scenario_steps?id=eq.d0000000-0000-4000-8000-000000000099');
  if (res.status !== 200 || !Array.isArray(res.data) || res.data.length !== 0) {
    throw new Error(`Expected 0 rows for draft step, got count ${res.data?.length}`);
  }
});

// 7. Negative Read: Coming Soon Scenarios Expose Card Information Only
await runTest('Coming Soon: Exposes card metadata but 0 child steps', async () => {
  const cardRes = await fetchJson('/scenarios?status=eq.coming_soon&select=slug');
  if (cardRes.status !== 200 || cardRes.data.length !== 3) {
    throw new Error(`Expected 3 coming soon cards, got count ${cardRes.data?.length}`);
  }
  const stepsRes = await fetchJson('/scenario_steps?scenario_id=eq.c0000000-0000-4000-8000-000000000002');
  if (stepsRes.data.length !== 0) {
    throw new Error(`Coming soon scenario leaked child steps! Count: ${stepsRes.data.length}`);
  }
});

// 8. Negative Mutation: Anonymous INSERT Denial
await runTest('Negative Mutation: Anonymous INSERT is strictly rejected (401/403)', async () => {
  const res = await fetchJson('/scenarios', {
    method: 'POST',
    body: JSON.stringify({ slug: 'tamper', category_id: 'a0000000-0000-4000-8000-000000000001', estimated_minutes: 5, status: 'published' }),
  });
  if (res.status === 201 || res.status === 200) {
    throw new Error(`Anonymous INSERT was permitted! HTTP ${res.status}`);
  }
});

// 9. Negative Mutation: Anonymous UPDATE Denial
await runTest('Negative Mutation: Anonymous UPDATE is strictly rejected (401/403/no-op)', async () => {
  const res = await fetchJson('/scenarios?id=eq.c0000000-0000-4000-8000-000000000001', {
    method: 'PATCH',
    body: JSON.stringify({ status: 'draft' }),
  });
  if (res.status === 200 || res.status === 204) {
    throw new Error(`Anonymous UPDATE was permitted! HTTP ${res.status}`);
  }
});

// 10. Media Asset Review Status Isolation
await runTest('Media Asset: Unreviewed media returns 0 rows', async () => {
  const res = await fetchJson('/media_assets?id=eq.b0000000-0000-4000-8000-000000000099');
  if (res.data.length !== 0) {
    throw new Error(`Unreviewed media asset leaked! Count: ${res.data.length}`);
  }
});

console.log('============================================================');
console.log(`Live Supabase Results: ${passed}/${passed + failed} passed.`);
console.log('============================================================');
if (failed > 0) process.exit(1);
