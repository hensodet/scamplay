import 'package:drift/drift.dart';
import 'scenario_categories_table.dart';
import 'media_assets_table.dart';

class CachedScenarios extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text()();
  TextColumn get categoryId => text().references(CachedScenarioCategories, #id)();
  TextColumn get coverMediaId => text().nullable().references(CachedMediaAssets, #id, onDelete: KeyAction.setNull)();
  IntColumn get estimatedMinutes => integer()();
  TextColumn get status => text()(); // 'published', 'coming_soon', 'archived', 'draft'
  IntColumn get version => integer().withDefault(const Constant(1))();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedScenarioLocalizations extends Table {
  TextColumn get scenarioId => text().references(CachedScenarios, #id, onDelete: KeyAction.cascade)();
  TextColumn get locale => text()(); // 'km' or 'en'
  TextColumn get title => text()();
  TextColumn get summary => text()();
  TextColumn get intro => text()();
  TextColumn get closingSummary => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {scenarioId, locale};
}
