import 'package:drift/drift.dart';

class CachedScenarioCategories extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedScenarioCategoryLocalizations extends Table {
  TextColumn get categoryId => text().references(CachedScenarioCategories, #id, onDelete: KeyAction.cascade)();
  TextColumn get locale => text()(); // 'km' or 'en'
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {categoryId, locale};
}
