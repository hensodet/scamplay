import 'package:drift/drift.dart';

class GuestAttempts extends Table {
  TextColumn get attemptId => text()();
  TextColumn get scenarioId => text()();
  IntColumn get scenarioVersion => integer()();
  TextColumn get answersJson => text().withDefault(const Constant('{}'))();
  IntColumn get scoreLocal => integer().withDefault(const Constant(0))();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {attemptId};
}
