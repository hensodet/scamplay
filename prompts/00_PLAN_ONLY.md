# FIRST PROMPT — M0 AUDIT AND PLAN ONLY

You are the technical lead for ScamPlay. This is a **new project with no application code yet**.

Read the root `AGENTS.md` and all files in `docs/`, plus all three sample-content JSON files. The package supersedes older web/PWA-first plans. **Current authorization: M0 planning only.**

Confirmed architecture: Flutter Android/iOS for PUBLIC USERS (no public web frontend); private Next.js + TypeScript web for ADMINS and selected server-side API functions; PostgreSQL via Supabase central data, SQLite via Drift local mobile cache; Khmer default + complete English content; illustrated Scenario Library cards; first playable Telegram/Facebook account-takeover story; demo news/video only if clearly labeled; all eight features planned but developed sequentially. Ownership remains undecided.

Tasks:
1. Audit all files for contradictory instructions, feasibility and missing decisions. Do not silently change product scope.
2. Propose the minimal repo layout and implementation boundaries; choose either approved-public-content Supabase Data API or a thin read API, justify it and explain RLS.
3. Propose a small initial PostgreSQL migration and Flutter SQLite cache schema, with content versioning and least-privilege access; do not execute it.
4. Propose M1 setup commands tailored to Windows; identify which tools are installed only if you have permission to run read-only version checks. Otherwise mark not tested.
5. Define how M2A, M2B, M3, M4 and M5 will be independently testable and approval gated.
6. Review bilingual JSON fixtures for schema consistency and security, distinguish mocked/unreviewed content and missing media.
7. Identify human decisions needed before provisioning Supabase or publishing any app, especially accounts, media rights and ownership.
8. Give a concise implementation plan, acceptance test matrix, risks, dependencies, and a STOP/approval checklist.

DO NOT: initialize apps, create folders outside planning docs, install packages, execute migrations, create cloud projects, connect accounts, open network resources, deploy, push Git, or implement any feature.

Output the M0 report. Update documentation only if explicitly approved to edit during M0. **Stop and await my explicit approval for M1.**
