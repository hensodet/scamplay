import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/scenario_categories_table.dart';
import 'tables/media_assets_table.dart';
import 'tables/scenarios_table.dart';
import 'tables/scenario_steps_table.dart';
import 'tables/answer_options_table.dart';
import 'tables/guest_attempts_table.dart';
import 'tables/app_preferences_table.dart';
import 'tables/sync_metadata_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  CachedScenarioCategories,
  CachedScenarioCategoryLocalizations,
  CachedMediaAssets,
  CachedMediaLocalizations,
  CachedScenarios,
  CachedScenarioLocalizations,
  CachedScenarioSteps,
  CachedStepLocalizations,
  CachedAnswerOptions,
  CachedAnswerLocalizations,
  GuestAttempts,
  AppPreferences,
  SyncMetadata,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await customStatement('PRAGMA foreign_keys = ON;');
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'scamplay.db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  // --- Preference helpers ---
  Future<String?> getPreference(String key) async {
    final query = select(appPreferences)..where((tbl) => tbl.key.equals(key));
    final result = await query.getSingleOrNull();
    return result?.value;
  }

  Future<void> setPreference(String key, String value) async {
    await into(appPreferences).insertOnConflictUpdate(
      AppPreferencesCompanion(
        key: Value(key),
        value: Value(value),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  // --- Sync metadata helpers ---
  Future<SyncMetadataData?> getSyncMetadata(String key) async {
    final query = select(syncMetadata)..where((tbl) => tbl.key.equals(key));
    return await query.getSingleOrNull();
  }

  Future<void> setSyncMetadata(String key, String value, DateTime lastSyncedAt) async {
    await into(syncMetadata).insertOnConflictUpdate(
      SyncMetadataCompanion(
        key: Value(key),
        value: Value(value),
        lastSyncedAt: Value(lastSyncedAt),
      ),
    );
  }

  // --- Guest attempt helpers ---
  Future<void> recordGuestAttempt(GuestAttemptsCompanion attempt) async {
    await into(guestAttempts).insertOnConflictUpdate(attempt);
  }

  Future<List<GuestAttempt>> getAllGuestAttempts() async {
    final query = select(guestAttempts)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]);
    return await query.get();
  }

  Future<GuestAttempt?> getGuestAttempt(String attemptId) async {
    final query = select(guestAttempts)..where((tbl) => tbl.attemptId.equals(attemptId));
    return await query.getSingleOrNull();
  }
}
