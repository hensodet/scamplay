# ScamPlay — START HERE (v3, 17 November 2026)

This is the **new mobile-first starter package**, superseding every prior ScamPlay web/PWA-first pack. It contains **specifications, sample content, and prompts**, not a completed running app. No cloud service has been created or connected for you.

## Decisions that must be respected
- **Public product:** Flutter for Android + iOS; **not** a general-user website.
- **Admin only:** Next.js + TypeScript web dashboard and selected shared server APIs.
- **Databases:** PostgreSQL via Supabase (central) and SQLite via Drift (local mobile cache/progress), introduced early **but only after separate approval**.
- **Language:** Khmer default and complete English support for each released item. Stable IDs are language-independent.
- **Pilot scenario:** fictional Telegram takeover attempt triggered by Messenger impersonation; first playable, with illustrated scenario cards.
- **Ownership:** unresolved; avoid institutional branding and unauthorized references. Public distribution is blocked until publisher/accountability and content review are assigned.
- **Scope:** all eight features planned; only the currently approved milestone may be built.
- **Development:** Google Antigravity, one workspace and source repository, milestone-by-milestone approval.

## Recommended first actions (Windows)
1. Install/check Git (`git --version`), Node.js LTS (`node --version`), Flutter stable (`flutter --version`), Dart (`dart --version`), Android Studio SDK/emulator (`flutter doctor -v`). Do **not** install anything automatically via agent before approving its plan. Xcode/iOS signing requires macOS later.
2. Extract this ZIP to a new folder such as `D:\Projects\ScamPlay`. Do not mix in the old web-first documents.
3. Open the folder as a project in Antigravity. Select **Software Engineering** layout if prompted and use review-oriented permissions. The exact labels vary by version; consult `docs/ANTIGRAVITY_SETUP_WINDOWS.md`.
4. Paste `prompts/00_PLAN_ONLY.md` into Antigravity. This first prompt authorizes **analysis only**. No code, installs, cloud creation or deployment.
5. Compare the report with `docs/REVIEW_GATE.md`, approve or request edits in writing. Next use `prompts/01_ENVIRONMENT_AFTER_APPROVAL.md` **only after approving M1**.
6. Move one gate at a time (`docs/ROADMAP.md`). Ask for real test output at each gate.

## File map
- `AGENTS.md`: agent-wide invariant rules.
- `docs/PRODUCT_VISION.md`: all eight planned features.
- `docs/PRD_PILOT.md`: currently authorized target behavior, not permission to build immediately.
- `docs/ARCHITECTURE.md`: physical and logical architecture, data flow, security boundaries.
- `docs/DATA_MODEL.md`: incremental PostgreSQL and SQLite design and synchronization.
- `docs/CONTENT_AND_MEDIA.md`: editorial rights, Khmer/English and audiovisual rules.
- `docs/ROADMAP.md`: milestones, deliverables, approval gates, testing.
- `docs/TEST_PLAN.md`: test matrix and measurable acceptance thresholds.
- `docs/DECISIONS_AND_RISKS.md`: known decisions, blockers, assumptions.
- `docs/RELEASE_GATE.md`: conditions before ANY public pilot or app store launch.
- `docs/ANTIGRAVITY_SETUP_WINDOWS.md`: workspace/setup and permission checklist.
- `docs/REVIEW_GATE.md`: human sign-off protocol.
- `prompts/`: approved per-milestone instructions.
- `sample-content/`: bilingual fictional data; *not reviewed or published*.
- `.gitignore`, `.env.example`: initial safe configuration conventions.

## What to expect
**M0 output:** architecture audit and acceptance-oriented implementation plan. **M1 output:** verified local toolchains/repository scaffold. **M2:** migration-backed central/local database integration. **M3–M4:** illustrated bilingual mobile Scenario Library and playable experience. **M5:** authenticated admin publishes content; phone fetches it. Remaining modules follow stage gates. These are not automatically started.

## Official references
- https://antigravity.google/docs/getting-started
- https://antigravity.google/docs/rules/
- https://antigravity.google/docs/permissions
- https://docs.flutter.dev/install
- https://supabase.com/docs/guides/getting-started/quickstarts/flutter
- https://supabase.com/docs/guides/local-development
- https://nextjs.org/docs/app/getting-started/route-handlers
