# Project status (M2A Completed & Verified)

Date: 2026-11-18
Current milestone: M2A (Development PostgreSQL Database, Schema Migrations, and Security Policies) — COMPLETED
Approved actions: Supabase development setup guide, schema migrations (20261118000001), security and RLS policies (20261118000002), seed demonstration content (20261118000003), automated verification suite, offline static analysis test.
Unapproved actions: Starting M2B (SQLite/Drift integration), connecting Flutter to live database, building admin dashboard, creating production databases, public deployment.

Completed in M2A:
- Schema Design & Migration (`20261118000001_create_scenario_schema.sql`): Created 11 relational tables covering categories, scenarios, localizations (km/en), steps, answers, media assets, audit timestamps, and version snapshot archival.
- Database Security & RLS Policies (`20261118000002_security_and_rls_policies.sql`):
  - Revoked public default privileges across all tables and routines.
  - Granted explicit `SELECT` privileges only to `anon` and `authenticated`.
  - Enabled RLS on all 11 tables with publication-state checks (`status = 'published'`).
  - Child tables (`scenario_steps`, `step_localizations`, `answer_options`, `answer_localizations`) strictly enforce scenario publication status via relational subqueries, preventing child data leaks from unpublished or preview scenarios.
  - Restricted storage bucket object access to approved media assets.
- Seed Demonstration Data (`20261118000003_seed_scenarios.sql`):
  - 1 complete published bilingual scenario (`telegram-messenger-takeover`) with 4 steps and 6 answer options.
  - 3 preview scenarios marked `coming_soon` with card metadata only.
  - 1 draft scenario and 1 archived scenario used for negative RLS testing.
- Automated SQL Verification Suite (`tests/sql/m2a_verification_suite.sql`): Implemented 9 automated tests verifying schema integrity, foreign keys, positive anonymous reads, negative draft/archived/child denials, and anonymous mutation rejections.
- Offline Static Analysis Test (`tests/verify_m2a_offline.mjs`): Executed with 14/14 tests passing.
- Supabase Development Setup Guide (`docs/SUPABASE_SETUP_GUIDE.md`): Provided detailed guidance for creating a free-tier development project in Singapore (`ap-southeast-1`) without secrets in source code.

Pending actions:
- Awaiting user review of M2A completion report and explicit written approval before proceeding to M2B (Local Drift SQLite & Offline Synchronization).

Next gate: M2B Approval (Flutter SQLite Integration & Synchronization).
