# Project status (M2A Remediation & Verification in Progress)

Date: 2026-11-18
Current milestone: M2A (Development PostgreSQL Database, Schema Migrations, and Security Policies) — REMEDIATION & VERIFICATION
Approved actions: Audit migration correctness, fix invalid UUID literals, refine schema privileges, update JSON schema contract, execute static verification, document content versioning, prepare live test runners.
Unapproved actions: Starting M2B (SQLite/Drift integration), connecting Flutter to live database, building admin dashboard, creating production databases, public deployment.

Completed in M2A Remediation:
- Migration Correctness Audit:
  - Fixed 107 UUID literals across seed data (`20261118000003_seed_scenarios.sql`) and SQL test harness (`tests/sql/m2a_verification_suite.sql`). Replaced invalid non-hexadecimal prefixes with RFC 4122 hexadecimal UUIDv4 strings.
  - Replaced blanket `REVOKE ALL ON ALL ...` with explicit table-targeted REVOKE/GRANT statements on ScamPlay tables, granting trigger execution privileges to `public.set_updated_at()`.
  - Reconciled `contracts/scenario.schema.json` status enum to include `coming_soon`.
  - Verified 11-table schema definitions, foreign keys, triggers, and ordering.
- Verification Testing:
  - Static Analysis Suite (`tests/verify_m2a_offline.mjs`): 18/18 checks passed, confirming all 107 seed UUIDs are valid hex literals, security grants strictly omit public write mutations, and sample fixtures match contracts.
  - SQL Verification Suite (`tests/sql/m2a_verification_suite.sql`): Updated with 10 comprehensive tests covering schema integrity, UUID rejection, foreign keys, unique keys, positive published reads, negative draft/archived/child isolation, anonymous and authenticated write denials, media review status filtering, and 100% bilingual parity.
  - Live PostgREST Verification Runner (`tests/verify_m2a_live.mjs`): Created to measure empirical round-trip HTTP latency and assert PostgREST anonymous access rules against a live development instance.
- Documentation:
  - Created `docs/CONTENT_VERSIONING.md` documenting stable identifier strategy, state machine transitions, immutable version snapshots, and historical attempt preservation.
  - Updated `docs/SUPABASE_SETUP_GUIDE.md` with step-by-step guidance for project creation and migration execution.
- Tooling Preflight:
  - Project-local Supabase CLI 3.2.0 installed in root `package.json` (`devDependencies`).
  - Executed `supabase init` generating version-controlled `supabase/config.toml`.
  - Added `.supabase_home/`, `.temp/`, and `supabase/.temp/` to `.gitignore`.

Pending actions for live database verification:
1. Complete `npx supabase login` and project linking (`npx supabase link --project-ref <ref>`).
2. Run non-mutating dry-run verification (`npx supabase db push --dry-run`).
3. Obtain explicit user approval before applying migrations.
4. Apply migrations `01`, `02`, `03` in development database.
5. Run `tests/sql/m2a_verification_suite.sql` in development database.
6. Execute `node tests/verify_m2a_live.mjs` to benchmark latency and verify PostgREST security.

Next gate: M2A Migration Execution Approval, followed by M2B.
