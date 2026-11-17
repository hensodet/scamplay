# Antigravity setup for Windows (review before clicking)

1. Visit https://antigravity.google/docs/getting-started and select the installation/launch method that matches the currently installed Antigravity App or IDE.
2. Extract the ScamPlay starter pack to `D:\Projects\ScamPlay` or another user-owned empty folder. Do not place secrets in the folder.
3. In Antigravity, create a Project and **Add Folder** selecting the ScamPlay root. It should see `AGENTS.md` and `docs/`.
4. Use the Software Engineering interface layout where available. Use a review-oriented agent mode. Google Antigravity App supports Local or isolated worktree project sessions; choose based on comfort/review needs.
5. Check Settings → General → Permission Settings or the current Agent Settings pane. Select **Request Review** (or equivalent ask-before-commands control), avoid Turbo/unrestricted execution, and review each proposed terminal command. On Windows available labels/implementation may vary by installed version.
6. Confirm `AGENTS.md` is recognized in workspace Rules/Customizations. It is an instruction, not an enforcement mechanism.
7. Paste the exact contents of `prompts/00_PLAN_ONLY.md` into the agent chat. DO NOT start a coding prompt yet.
8. If an agent suggests installing CLI tools, cloud provisioning, creating a Supabase project, or connecting any account in M0, **deny that action** and restate scope.
9. Review M0 plan. Only approve one following stage using `docs/REVIEW_GATE.md`.

## User prerequisite checklist (for M1, not required for M0)
- Git installed; `git --version`.
- Node.js supported LTS; `node --version`; `npm --version`.
- Flutter stable, Dart and Android SDK/Android Studio; `flutter doctor -v`.
- Android phone with USB debugging or Android emulator for builds.
- Docker Desktop or equivalent only if choosing local Supabase development. A **cloud dev Supabase** project is an alternative for M2 with user-controlled setup; decide this at M0.
- macOS/Xcode/Apple account or approved cloud build service needed for full iOS builds/signing later; Windows by itself cannot complete standard iOS signing.

## External references
- https://antigravity.google/docs/getting-started
- https://antigravity.google/docs/rules/
- https://antigravity.google/docs/permissions
- https://docs.flutter.dev/install
