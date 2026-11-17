# Pilot PRD — authoritative scope for first integrated playable experience

## Product and audience
ScamPlay public frontend is a Flutter app for Android and iOS. First practical device testing will prioritize Android on Windows; do not claim iOS is compiled/tested without a macOS/Xcode environment. Admin uses private Next.js web. Khmer default, English complete.

## First integrated user journey
1. Welcome/home screen with bilingual language switcher and clear independent educational prototype notice.
2. Scenario Library: **illustrated cards** with title/description/category/duration/status. Initially 4 entries: Telegram/Facebook takeover **playable**, shopping/bank impersonation/investment **Coming Soon**. Covers are licensed or original; do not imply previews are playable.
3. Tap playable scenario → introduction → short narrative steps with fictional Messenger-style visual (not a deceptive copy of proprietary UI).
4. At least 2 interactive decisions, answer options, user-selected responses, explanations and consequences; readable text and optional **user-triggered** Khmer/English prerecorded audio.
5. Results / lesson summary / replay / return to library. Guest progress stays on device locally; no identity required.
6. Central PostgreSQL provides approved versioned scenario metadata/content; Flutter caches approved content in SQLite; reconnect checks updates by version. An offline launch with previously downloaded scenario continues to work. Graceful empty/unavailable states on fresh offline installs.
7. Admin can publish **only after M5**: earlier milestone uses controlled seed/migrations, not ad hoc admin UIs.

## Demo previews for other six modules
- Display clearly marked **demo/coming soon** placeholders for News, Educational Videos, Emergency Help, Contact Directory, Safety Health Check, Legal Education, AI Lab. A sample news fixture is **fictional** and not displayed as real current news; sample video needs a rights-cleared asset before playback. Do not present false functionality.
- The eight modules should be visible in the **final** navigation plan; avoid clutter in the first screen. Modules cannot be declared complete when represented only by a preview tile.

## Admin and backend
- Next.js admin and API introduced in dedicated M5, not built in M1/M2 by default. Supabase Data API can be used for read-only published content under least-privilege RLS; custom API/services used for privileged mutations/workflows. Never expose admin credentials or secrets to Flutter.

## Quality requirements
- Responsive layouts for tested Android widths; English/Khmer completeness; loading/error/offline states; accessibility; no horizontal text clipping.
- A complete **reviewed bilingual script** and source/permissions record is needed for public launch. Seed scripts are **unapproved** fiction.
- Source/media and emergency advice should use official/verified guidance; no unofficial recovery promises.
- No public release until `docs/RELEASE_GATE.md` passes.

## Excluded from initial executable scope
- Live AI Lab, auto news crawling, certified scoring, user accounts, certificate issuance, full emergency directory, live bank/police contacts, payment systems, production sync, automatic device-wide scans, bulk media production, public web UI.
