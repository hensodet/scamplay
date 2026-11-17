# Task register

**Current authorization: M2B — FLUTTER LOCAL SQLITE (DRIFT) INTEGRATION & OFFLINE DATA MANAGEMENT (COMPLETED)**

- [x] M0 audit all starter documents for inconsistent scope.
- [x] M0 confirm minimum technical schema approach and backend read path.
- [x] M0 evaluate licenses, content permissions, and initial case wording.
- [x] M0 propose exact toolchain checks and commands for M1 on Windows.
- [x] M0 identify unresolved publishing/security/ownership gates.
- [x] M0 submit planning report with precise exit criteria for M1.
- [x] M0 incorporate final review corrections (clarify PostgREST caching, SQLite offline sync, Next.js boundaries, Windows toolchain).
- [x] Obtain written user approval for M1 (Approved 17 Nov 2026).
- [x] M1 check Windows development environment (Node.js v24.11.1 and npm.cmd v11.6.2 verified; Git 2.56.0, Flutter 3.50.0, Dart 3.14.0, Java JDK 25, Android SDK 37 verified).
- [x] M1 establish agreed monorepo structure (apps/mobile, apps/admin-web, supabase/migrations, contracts, tests).
- [x] M1 configure comprehensive .gitignore covering Flutter, Next.js, and security boundaries.
- [x] M1 scaffold minimal Flutter mobile application shell with bilingual architecture and smoke test.
- [x] M1 scaffold minimal Next.js TypeScript Tailwind CSS private admin web shell.
- [x] M1 define data contracts in contracts/ (scenario.schema.json, manifest.schema.json).
- [x] M1 record required M2 technical corrections in docs/ARCHITECTURE.md and docs/DATA_MODEL.md.
- [x] M1 upgrade apps/admin-web to Next.js 16.4.6 (React 19, TypeScript 5.7, Tailwind CSS 3.4).
- [x] M1 install Next.js dependencies via npm.cmd and verify clean production build (next build --webpack).
- [x] Configure Git for Windows (v2.56.0) on host.
- [x] Initialize Git repository and create initial commit (8ebf842).
- [x] Configure Flutter SDK (3.50.0), Android Studio, Android SDK (37), NDK (28.2), and JBR JDK 25 on host.
- [x] Complete Flutter CLI hydration (flutter create .), analysis (0 issues), tests (passed), debug APK build (exit 0), and physical Android device run on ALI NX1 (verified in Khmer and English).
- [x] Obtain written user approval for M2A (Approved 18 Nov 2026).
- [x] M2A Remediation: Audit and correct all invalid UUID literals across seed data and test suites (107/107 strictly valid hex UUIDv4).
- [x] M2A Remediation: Replace blanket schema privilege revokes with explicit table targets, grant trigger function execute privileges, and verify authenticated role write denials.
- [x] M2A Remediation: Reconcile contracts/scenario.schema.json status enum to include 'coming_soon'.
- [x] M2A Remediation: Document content versioning, stable identifiers, state transitions, and attempt preservation (docs/CONTENT_VERSIONING.md).
- [x] M2A Remediation: Static verification and contract alignment test executed (tests/verify_m2a_offline.mjs: 18/18 passed).
- [x] M2A Remediation: Create live PostgREST test runner measuring round-trip latency and verifying anon access (tests/verify_m2a_live.mjs).
- [x] M2A Preflight: Configure project-local Supabase CLI 3.2.0 and generate supabase/config.toml.
- [x] M2A Preflight: Authenticate CLI and verify link to development project 'scamplay-dev' (ujpyanjnmtxpolhodzkl).
- [x] M2A Preflight: Inspect remote migration history (npx.cmd --no-install supabase migration list --remote: 0 remote, 3 pending).
- [x] M2A Preflight: Run non-mutating dry-run migration check (npx.cmd --no-install supabase db push --dry-run --remote: verified exit 0, 0 remote mutations).
- [x] Obtain explicit user approval before applying migrations (Approved 18 Nov 2026).
- [x] Apply migrations 01, 02, 03 to development database scamplay-dev (npx.cmd --no-install supabase db push --remote --yes: exit 0, all 3 migrations recorded).
- [x] Execute in-database SQL verification suite on scamplay-dev (tests/sql/run_m2a_verification.sql: 14/14 tests PASSED).
- [x] Execute live PostgREST API verification suite against scamplay-dev (tests/verify_m2a_live.mjs: 9/9 tests PASSED, round-trip latency measured).
- [x] Verify remote database linter (supabase db lint --remote: 0 schema errors found).
- [x] Obtain written user approval for M2B (Approved 18 Nov 2026).
- [x] M2B Implement Drift 2.31 SQLite schema mirroring 11 remote tables + local guest attempts, app preferences, and sync metadata.
- [x] M2B Generate Drift database code via build_runner (app_database.g.dart).
- [x] M2B Implement ContentRepository with bilingual card and detail queries, persistent guest attempt tracking, and language preference management.
- [x] M2B Implement SyncService for read-only Supabase synchronization using public anon key, bilingual completeness validation, and atomic transaction updates.
- [x] M2B Wire SQLite persistence to Flutter UI (language switcher persistence across restarts, offline cache status banner, offline fallback handling).
- [x] M2B Automated testing: 10/10 unit, sync, and widget tests passed (flutter test).
- [x] M2B Static analysis: flutter analyze returned 0 issues.
- [x] M2B Build verification: flutter build apk --debug succeeded (app-debug.apk, exit 0).
- [x] M2B Handset verification on ALI NX1: verified live sync from Supabase, bilingual switching (km/en), persistent English selection across app cold restart, and offline boot in Airplane Mode with full cached scenario rendering.
- [ ] Obtain written user approval for M3 (Scenario Library UI).

Change this tracker only within the approved milestone. Mark executed tests separately from planned tests. Do not mark checkboxes until actually complete.
