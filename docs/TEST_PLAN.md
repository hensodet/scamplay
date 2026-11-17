# Testing and exit criteria — proposal, not performed

## Per-stage evidence format
- Unit/widget/integration tests: command, timestamp, exit status, short observed output.
- Physical device tests: model, Android version, network state, locale, screenshot/video, actual result.
- Security: tested anon/auth/admin role, expected vs observed actions. Never claim independent audit unless performed.
- Manual tests: checklist with PASS/FAIL/NOT EXECUTED; record reproduction steps.

## M1 environment gate
- `git --version`, `node --version`, `npm --version`, `flutter --version`, `flutter doctor -v`, `dart --version` recorded.
- Flutter sample boots on available Android device/emulator. Next.js admin shell starts locally. No secret committed.

## M2 integration gate
- Supabase migrations execute in **development**, rollback documented; RLS on every exposed table.
- Public client can read published content and cannot read drafts or write data.
- Draft/secret/admin data denied to anon; role-matrix negative tests pass.
- Flutter fetches versioned scenario, caches it, loads cached copy offline after a restart, handles empty-first-run and interrupted download.
- SQLite migration and cache reset test. Version-atomic update and stale content behavior documented.

## M3–M4 UX/functional gate
- Khmer and English render correct unique translations; no untranslated keys.
- Card image/placeholder, labels and enabled/disabled status match actual behavior.
- Answer selection, feedback, score, replay, progress and change-language preserve same scenario/option IDs.
- Audio requires play gesture and supports pause/replay/text fallback; files actually played are verified.
- Screens and large touch targets visually inspected on target devices; keyboard/screen reader behavior reviewed where supported.

## Participant evaluation (after safety gate)
- Plan 15–20 consented participants across varying ages, literacy and devices for exploratory usability; not population-wide evidence.
- Counterbalanced short pre/post conceptual questions; optional delayed retest after 7–14 days with volunteers.
- **Provisional targets:** >=80% unassisted completion; >=80% correctly state that OTP/login codes must not be shared; >=70% rate clarity >=4/5. These thresholds must be approved before testing.
- Record qualitative failure themes, navigation friction, audio comprehension and engagement. Specify *stop/redesign/continue* after each pilot; any unsafe guidance blocks release regardless of score.
- Collect data with approved consent process and separation from production analytics. Do not invent research results.

## Release gate
- All known severe security defects closed or risk-accepted by qualified reviewer, backup restore tested, contact/incident guide signed off, privacy/legal and media rights reviewed, app-store policy checked, responsible publisher named.
