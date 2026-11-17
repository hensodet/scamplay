// tests/verify_m2a_offline.mjs
// Offline migration, UUID validity, and contract verification test for M2A
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

// 2. Validate All UUID Literals in Seed Data
const seedSql = fs.readFileSync(path.join(MIGRATIONS_DIR, '20261118000003_seed_scenarios.sql'), 'utf8');
const uuidRegex = /[0-9a-zA-Z]{8}-[0-9a-zA-Z]{4}-[0-9a-zA-Z]{4}-[0-9a-zA-Z]{4}-[0-9a-zA-Z]{12}/g;
const strictHexUuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

const foundUuids = seedSql.match(uuidRegex) || [];
assert(foundUuids.length > 0, `Found ${foundUuids.length} UUID literals in seed data`);

let allUuidsValid = true;
let invalidUuidList = [];
for (const uuid of foundUuids) {
  if (!strictHexUuidRegex.test(uuid)) {
    allUuidsValid = false;
    invalidUuidList.push(uuid);
  }
}
assert(
  allUuidsValid,
  `All seed UUIDs are strictly valid hexadecimal literals (Invalid: ${invalidUuidList.join(', ')})`
);

// 3. Static Analysis on Security Migration
const secSql = fs.readFileSync(path.join(MIGRATIONS_DIR, '20261118000002_security_and_rls_policies.sql'), 'utf8');

assert(
  secSql.includes('REVOKE ALL ON TABLE') && secSql.includes('FROM public, anon, authenticated;'),
  'Security migration explicitly revokes table permissions from public, anon, and authenticated'
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
  !secSql.includes('GRANT INSERT ON') && !secSql.includes('GRANT UPDATE ON') && !secSql.includes('GRANT DELETE ON'),
  'Security migration grants zero write permissions to anon/authenticated'
);

// 4. Verify Sample Content & Contract Compatibility
const sampleTakeoverPath = path.join(SAMPLE_DIR, 'scenario_telegram_takeover.demo.json');
assert(fs.existsSync(sampleTakeoverPath), 'Demo scenario fixture exists');
const takeoverData = JSON.parse(fs.readFileSync(sampleTakeoverPath, 'utf8'));

assert(takeoverData.id === 'telegram-messenger-takeover', 'Scenario ID matches expected slug');
assert(takeoverData.localizations.km && takeoverData.localizations.en, 'Scenario has bilingual root localizations');
assert(Array.isArray(takeoverData.steps) && takeoverData.steps.length === 4, 'Scenario has 4 steps matching migration seed');

// 5. Verify Scenario JSON Schema Contract
const schemaPath = path.join(CONTRACTS_DIR, 'scenario.schema.json');
const schemaData = JSON.parse(fs.readFileSync(schemaPath, 'utf8'));
assert(schemaData.properties.status.enum.includes('coming_soon'), 'Scenario schema contract includes coming_soon status');
assert(schemaData.properties.status.enum.includes('published'), 'Scenario schema contract includes published status');

console.log('============================================================');
console.log(`Results: ${passedTests}/${totalTests} tests passed.`);
console.log('============================================================');
