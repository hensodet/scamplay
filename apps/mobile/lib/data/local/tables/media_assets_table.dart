import 'package:drift/drift.dart';

class CachedMediaAssets extends Table {
  TextColumn get id => text()();
  TextColumn get storagePath => text()();
  TextColumn get mediaType => text()(); // 'image', 'audio', 'video'
  TextColumn get mimeType => text()();
  IntColumn get sizeBytes => integer().nullable()();
  TextColumn get contentHash => text().nullable()();
  TextColumn get licenseStatus => text()(); // 'licensed_demo', 'original', 'unreviewed_placeholder'
  TextColumn get reviewStatus => text()(); // 'approved', 'pending_review', 'rejected'
  TextColumn get localPath => text().nullable()(); // local cached file path on device
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedMediaLocalizations extends Table {
  TextColumn get mediaAssetId => text().references(CachedMediaAssets, #id, onDelete: KeyAction.cascade)();
  TextColumn get locale => text()(); // 'km' or 'en'
  TextColumn get altText => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {mediaAssetId, locale};
}
