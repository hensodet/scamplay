// tests/verify_m2a_offline.mjs
// Offline migration and contract verification test for M2A
import fs from 'node:fs';
import path from 'node:path';

const ROOT_DIR = process.cwd();
const MIGRATIONS_DIR = path.join(ROOT_DIR, 'supabase', 'migrations');
const CONTRACTS_DIR = path.join(ROOT_DIR, 'contracts');
const SAMPLE_DIR = path.join(ROOT_DIR, 'sample-content');

let passedTests = 0;
let totalTests = 0;

function assert(condition, message) {
  totalTests++;
  if (!condition) {
    console.error(`[FAIL] ${message}`);
    process.exitCode = 1;
  } else {
    passedTests++;
    console.log(`[PASS] ${message}`);
  }
}

console.log('============================================================');
console.log('ScamPlay M2A Local Verification & Static Analysis Suite');
console.log('============================================================');

// 1. Verify Migration Files
const migrationFiles = [
  '20261118000001_create_scenario_schema.sql',
  '20261118000002_security_and_rls_policies.sql',
  '20261118000003_seed_scenarios.sql',
];

for (const file of migrationFiles) {
  const filePath = path.join(MIGRATIONS_DIR, file);
  assert(fs.existsSync(filePath), `Migration file exists: ${file}`);
  const content = fs.readFileSync(filePath, 'utf8');
  assert(content.length > 50, `Migration file is non-empty: ${file}`);
}

// 2. Static Analysis on Security Migration
const secSql = fs.readFileSync(path.join(MIGRATIONS_DIR, '20261118000002_security_and_rls_policies.sql'), 'utf8');

assert(
  secSql.includes('REVOKE ALL ON ALL TABLES IN SCHEMA public FROM public;'),
  'Security migration revokes public permissions'
);

assert(
  secSql.includes('ENABLE ROW LEVEL SECURITY;'),
  'Security migration enables Row Level Security'
);

assert(
  secSql.includes("status = 'published'"),
  "Security migration enforces status = 'published' on child tables"
);

assert(
  !secSql.includes('GRANT ALL ON ALL TABLES') && !secSql.includes('GRANT INSERT ON') && !secSql.includes('GRANT UPDATE ON') && !secSql.includes('GRANT DELETE ON'),
  'Security migration grants zero write permissions to anon/authenticated'
);

// 3. Verify Sample Content & Contract Compatibility
const sampleTakeoverPath = path.join(SAMPLE_DIR, 'scenario_telegram_takeover.demo.json');
assert(fs.existsSync(sampleTakeoverPath), 'Demo scenario fixture exists');
const takeoverData = JSON.parse(fs.readFileSync(sampleTakeoverPath, 'utf8'));

assert(takeoverData.id === 'telegram-messenger-takeover', 'Scenario ID matches expected slug');
assert(takeoverData.localizations.km && takeoverData.localizations.en, 'Scenario has bilingual root localizations');
assert(Array.isArray(takeoverData.steps) && takeoverData.steps.length === 4, 'Scenario has 4 steps matching migration seed');

console.log('============================================================');
console.log(`Results: ${passedTests}/${totalTests} tests passed.`);
console.log('============================================================');
