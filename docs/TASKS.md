# Task register

**Current authorization: M2A — DEVELOPMENT POSTGRESQL SCHEMA, MIGRATIONS & RLS (COMPLETED)**

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
- [x] M2A Create Supabase development setup guide (Singapore region, Free Tier, non-secret credentials).
- [x] M2A Implement core scenario relational schema migration (supabase/migrations/20261118000001_create_scenario_schema.sql).
- [x] M2A Implement explicit privileges and child-level RLS policies (supabase/migrations/20261118000002_security_and_rls_policies.sql).
- [x] M2A Implement bilingual seed demonstration data with 1 published and 3 coming soon scenarios (supabase/migrations/20261118000003_seed_scenarios.sql).
- [x] M2A Build automated SQL security test suite verifying RLS positive/negative reads and write rejections (tests/sql/m2a_verification_suite.sql).
- [x] M2A Build and execute static analysis and contract verification test suite (tests/verify_m2a_offline.mjs: 14/14 passed).
- [ ] Obtain written user approval for M2B.
- [ ] M2B Flutter local SQLite (Drift) integration and offline synchronization.

Change this tracker only within the approved milestone. Mark executed tests separately from planned tests. Do not mark checkboxes until actually complete.
