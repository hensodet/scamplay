# Project status (M2A Completed & Verified Live)

Date: 2026-11-18
Current milestone: M2A (Development PostgreSQL Database, Schema Migrations, and Security Policies) — COMPLETED & FULLY VERIFIED
Approved actions: Audit migration correctness, fix UUID literals, link scamplay-dev, execute migrations 01/02/03 via CLI, execute in-database SQL verification suite, execute live PostgREST API suite, update trackers.
Unapproved actions: Starting M2B (SQLite/Drift integration), connecting Flutter to live database, building admin dashboard, creating production databases, public deployment.

Completed in M2A:
- Schema Design & Deployment:
  - Deployed 3 version-controlled migrations to dedicated development project `scamplay-dev` (ref: `ujpyanjnmtxpolhodzkl`, Singapore `ap-southeast-1`, Postgres 17.12.0) via `npx.cmd --no-install supabase db push --remote --yes` (exit code 0).
  - All 11 application tables created: `scenario_categories`, `scenario_category_localizations`, `media_assets`, `media_localizations`, `scenarios`, `scenario_localizations`, `scenario_steps`, `step_localizations`, `answer_options`, `answer_localizations`, `scenario_versions`.
  - All 3 migrations recorded in remote migration history catalog `supabase_migrations.schema_migrations`.
- Database Security & RLS Policies:
  - Revoked public default privileges across all 11 tables.
  - Granted least-privilege `SELECT` strictly to `anon` and `authenticated`.
  - Revoked `EXECUTE` on trigger function `public.set_updated_at()` from untrusted roles.
  - Enabled RLS on all 11 tables with publication-state checks (`status = 'published'`).
  - Child tables (`scenario_steps`, `step_localizations`, `answer_options`, `answer_localizations`) enforce scenario publication status via relational subqueries, preventing child data leaks from unpublished or preview scenarios.
  - Private storage bucket `scenario-media` configured (`public = false`) with strict access policy allowing only approved media linked to active scenarios.
- Seed Demonstration Data:
  - 1 complete published bilingual scenario (`telegram-messenger-takeover`) with 4 steps and 6 answer options.
  - 3 preview scenarios marked `coming_soon` with card metadata only.
  - 1 draft scenario and 1 archived scenario used for negative RLS testing.
  - 107/107 UUID literals verified strictly valid hexadecimal RFC 4122 strings.
- Automated In-Database SQL Verification Suite (`tests/sql/run_m2a_verification.sql`):
  - Executed directly against `scamplay-dev` using `supabase db query --remote`: **14/14 tests PASSED**.
  - Verified schema inventory, invalid UUID rejection, foreign keys, unique keys, positive anonymous reads, draft/archived zero-row isolation, child-step shielding, coming-soon card visibility with zero child steps, anonymous mutation denial, authenticated non-admin write denial, trigger execution denial, media review filtering, 100% bilingual parity, and storage bucket privacy.
- Live PostgREST API Verification Suite (`tests/verify_m2a_live.mjs`):
  - Executed over HTTPS against `https://ujpyanjnmtxpolhodzkl.supabase.co`: **9/9 tests PASSED**.
  - Empirical HTTP round-trip latency measured: ~1103ms initial connection, ~220-280ms per query.
  - Verified API-level status codes: HTTP 200 for published content, 0 rows for drafts, HTTP 401/403 for mutations.
- Database Schema Linter (`supabase db lint --remote`):
  - 0 schema errors found across `public` and `extensions` schemas.

Pending actions:
- Awaiting user review of M2A final completion report and explicit written approval before proceeding to M2B (Local Drift SQLite & Offline Synchronization).

Next gate: M2B Approval (Flutter SQLite Integration & Synchronization).
