# Project status (M2B Completed & Fully Verified)

Date: 2026-11-18
Current milestone: M2B (Flutter Local SQLite/Drift Integration and Offline Data Management) — COMPLETED & FULLY VERIFIED
Approved actions: Drift 2.31 SQLite schema mirroring 11 remote tables + local guest attempts, app preferences, and sync metadata; build_runner code generation; ContentRepository with bilingual card and detail queries; SyncService for read-only Supabase synchronization with bilingual completeness validation and atomic transaction updates; language switcher persistence; unit/sync/widget tests; debug APK build; physical device verification on ALI NX1 (online sync, bilingual toggle, persistent cold reboot, offline airplane mode).
Unapproved actions: Starting M3 (Scenario Library UI design/overhaul), building M4 gameplay interactions, building admin dashboard, creating production databases, cloud progress upload.

Completed in M2B:
- Local Drift 2.31 SQLite Architecture:
  - Integrated `drift: ^2.24.2`, `drift_flutter: ^0.2.4`, `sqlite3_flutter_libs: ^0.5.42`, `path_provider: ^2.1.6`, and `http: ^1.6.0`.
  - Implemented 8 modular table definitions in `apps/mobile/lib/data/local/tables/`:
    - `CachedScenarioCategories`, `CachedScenarioCategoryLocalizations`
    - `CachedMediaAssets`, `CachedMediaLocalizations`
    - `CachedScenarios`, `CachedScenarioLocalizations`
    - `CachedScenarioSteps`, `CachedStepLocalizations`
    - `CachedAnswerOptions`, `CachedAnswerLocalizations`
    - `GuestAttempts` (attemptId, scenarioId, scenarioVersion, answersJson, scoreLocal, completed, completedAt, createdAt, updatedAt)
    - `AppPreferences` (key, value, updatedAt)
    - `SyncMetadata` (key, value, lastSyncedAt)
  - Generated Drift database implementation via `build_runner` (`app_database.g.dart`) with PRAGMA foreign_keys = ON.
- Content Repository & Local Progress (`apps/mobile/lib/data/repositories/content_repository.dart`):
  - Bilingual card queries joining categories, scenarios, and localizations.
  - Complete hierarchical scenario detail queries (scenarios -> steps -> options with localized labels and feedback).
  - Guest attempt tracking: local provisional scores, completion flags, and JSON answers stored safely on-device without network transmission.
  - Language preference management defaulting to Khmer (`km`), supporting English (`en`), and persisting across app lifecycles.
- Read-Only Supabase Synchronization (`apps/mobile/lib/data/sync/sync_service.dart`):
  - Fetches published scenarios and approved coming-soon cards using public anon key only.
  - Strict bilingual completeness validation: rejects payloads if either Khmer (`km`) or English (`en`) translations are missing.
  - Atomic cache updates: clears and repopulates cache tables inside a single Drift SQLite transaction (`db.transaction`).
  - Strict isolation: `GuestAttempts` and `AppPreferences` are completely decoupled and preserved across content updates or sync failures.
  - Resilient error handling: network timeouts and HTTP errors roll back cleanly, leaving previous valid cache intact.
- Automated Testing Suite:
  - `flutter analyze`: 0 errors, 0 warnings across all application and test files.
  - `flutter test`: **10/10 tests PASSED** in 4s:
    - 5/5 database and repository tests (CRUD, foreign keys, language persistence, attempt preservation).
    - 4/4 sync service tests (successful atomic sync, bilingual validation failure, HTTP 500 rollback, attempt preservation).
    - 1/1 widget test verifying UI rendering, bilingual switcher toggle, and database persistence.
- Production-Ready Debug Build:
  - `flutter build apk --debug` succeeded cleanly (exit code 0; `app-debug.apk`, 189 MB).
- Physical Handset Verification (`ALI NX1`, `AWCXUT4115006583`, Android 15, API 35):
  - Successfully installed APK via ADB.
  - Online sync executed on initial launch: fetched and cached 4 scenarios from remote Supabase development database `scamplay-dev`.
  - Bilingual toggle verified: instantly switched UI between Khmer and English with full text parity.
  - Cold reboot persistence verified: app force-stopped and re-launched; restored directly into previously selected English locale from SQLite `AppPreferences`.
  - Offline mode verified: device placed in Airplane Mode; app cold-booted offline and rendered all 4 scenario cards directly from local Drift SQLite cache without network.

Pending actions:
- Awaiting user review of M2B completion report and explicit written approval before proceeding to M3 (Scenario Library UI).

Next gate: M3 Approval (Scenario Library UI).
