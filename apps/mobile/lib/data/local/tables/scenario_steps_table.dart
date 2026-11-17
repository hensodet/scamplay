import 'package:drift/drift.dart';
import 'scenarios_table.dart';
import 'media_assets_table.dart';

class CachedScenarioSteps extends Table {
  TextColumn get id => text()();
  TextColumn get scenarioId => text().references(CachedScenarios, #id, onDelete: KeyAction.cascade)();
  TextColumn get stepKey => text()();
  TextColumn get kind => text()(); // 'story', 'decision', 'feedback'
  IntColumn get orderIndex => integer()();
  TextColumn get mediaAssetId => text().nullable().references(CachedMediaAssets, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedStepLocalizations extends Table {
  TextColumn get stepId => text().references(CachedScenarioSteps, #id, onDelete: KeyAction.cascade)();
  TextColumn get locale => text()(); // 'km' or 'en'
  TextColumn get bodyText => text()();
  TextColumn get narrationMediaId => text().nullable().references(CachedMediaAssets, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {stepId, locale};
}
