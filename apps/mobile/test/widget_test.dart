import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:mobile/app.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/repositories/content_repository.dart';
import 'package:mobile/data/sync/sync_service.dart';

void main() {
  late AppDatabase db;
  late DriftContentRepository repository;
  late SyncService syncService;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftContentRepository(db);
    syncService = SyncService(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('ScamPlayApp renders with bilingual switcher and persists language', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScamPlayApp(
        repository: repository,
        syncService: syncService,
        initialLocale: const Locale('km'),
      ),
    );
    await tester.pumpAndSettle();

    // Verify initial Khmer title and switcher
    expect(find.text('ScamPlay'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('បណ្ណាល័យសេណារីយ៉ូ'), findsOneWidget);

    // Initial preference in DB should be default 'km'
    expect(await repository.getLanguagePreference(), equals('km'));

    // Switch to English
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Verify English UI
    expect(find.text('ScamPlay'), findsOneWidget);
    expect(find.text('ភាសាខ្មែរ'), findsOneWidget);
    expect(find.text('Scenario Library'), findsOneWidget);

    // Verify language preference was saved to Drift SQLite
    expect(await repository.getLanguagePreference(), equals('en'));

    // Switch back to Khmer
    await tester.tap(find.text('ភាសាខ្មែរ'));
    await tester.pumpAndSettle();

    // Verify Khmer UI restored
    expect(find.text('ScamPlay'), findsOneWidget);
    expect(await repository.getLanguagePreference(), equals('km'));
  });
}
