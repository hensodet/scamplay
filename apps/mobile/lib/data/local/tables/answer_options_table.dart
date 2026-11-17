import 'package:drift/drift.dart';
import 'scenario_steps_table.dart';

class CachedAnswerOptions extends Table {
  TextColumn get id => text()();
  TextColumn get stepId => text().references(CachedScenarioSteps, #id, onDelete: KeyAction.cascade)();
  TextColumn get optionKey => text()();
  IntColumn get orderIndex => integer()();
  IntColumn get scoreValue => integer().withDefault(const Constant(0))();
  TextColumn get safetyCategory => text()(); // 'safe', 'unsafe', 'caution'
  TextColumn get nextStepId => text().nullable().references(CachedScenarioSteps, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedAnswerLocalizations extends Table {
  TextColumn get optionId => text().references(CachedAnswerOptions, #id, onDelete: KeyAction.cascade)();
  TextColumn get locale => text()(); // 'km' or 'en'
  TextColumn get label => text()();
  TextColumn get feedbackText => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {optionId, locale};
}
