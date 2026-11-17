import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:mobile/app.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/repositories/content_repository.dart';
import 'package:mobile/data/sync/sync_service.dart';
import 'package:mobile/ui/screens/scenario_detail_screen.dart';
import 'package:mobile/ui/widgets/coming_soon_sheet.dart';
import 'package:mobile/ui/widgets/scenario_card_widget.dart';

void main() {
  late AppDatabase db;
  late DriftContentRepository repository;
  late SyncService syncService;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftContentRepository(db);
    syncService = SyncService(db: db);

    // Seed 4 public scenarios mirroring M2A remote database
    final now = DateTime.utc(2026, 11, 18, 0, 0, 0);

    // 1. Categories
    await db.into(db.cachedScenarioCategories).insert(
          CachedScenarioCategoriesCompanion.insert(
            id: 'cat-1',
            slug: 'account_takeover',
            sortOrder: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioCategories).insert(
          CachedScenarioCategoriesCompanion.insert(
            id: 'cat-2',
            slug: 'fake_online_store',
            sortOrder: const Value(2),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioCategories).insert(
          CachedScenarioCategoriesCompanion.insert(
            id: 'cat-3',
            slug: 'bank_impersonation',
            sortOrder: const Value(3),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioCategories).insert(
          CachedScenarioCategoriesCompanion.insert(
            id: 'cat-4',
            slug: 'fake_investment',
            sortOrder: const Value(4),
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Category Localizations
    final catLocs = [
      {'id': 'cat-1', 'km': 'ការបន្លំដណ្ដើមគណនី', 'en': 'Account Takeover'},
      {'id': 'cat-2', 'km': 'ហាងអនឡាញក្លែងក្លាយ', 'en': 'Fake Online Store'},
      {'id': 'cat-3', 'km': 'ការក្លែងបន្លំធនាគារ', 'en': 'Bank Impersonation'},
      {'id': 'cat-4', 'km': 'ការវិនិយោគក្លែងក្លាយ', 'en': 'Fake Investment'},
    ];
    for (final c in catLocs) {
      await db.into(db.cachedScenarioCategoryLocalizations).insert(
            CachedScenarioCategoryLocalizationsCompanion.insert(
              categoryId: c['id']!,
              locale: 'km',
              name: c['km']!,
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedScenarioCategoryLocalizations).insert(
            CachedScenarioCategoryLocalizationsCompanion.insert(
              categoryId: c['id']!,
              locale: 'en',
              name: c['en']!,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    // 2. Scenarios
    // Scenario 1: Published Telegram Takeover
    await db.into(db.cachedScenarios).insert(
          CachedScenariosCompanion.insert(
            id: 'scen-1',
            slug: 'telegram-messenger-takeover',
            categoryId: 'cat-1',
            estimatedMinutes: 6,
            status: 'published',
            version: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-1',
            locale: 'km',
            title: 'ល្បិចបោកយកគណនី Telegram',
            summary: 'ស្វែងយល់ពីសារក្លែងបន្លំតាម Messenger ដែលព្យាយាមយកលេខកូដចូល Telegram។',
            intro: 'អ្នកទទួលបានសារពីគណនី Messenger មួយដែលមើលទៅដូចជាមិត្តភក្តិរបស់អ្នក។',
            closingSummary: 'កុំចែករំលែកលេខកូដចូលគណនី។ ផ្ទៀងផ្ទាត់ការស្នើសុំតាមមធ្យោបាយទំនាក់ទំនងដែលអ្នកទុកចិត្ត។',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-1',
            locale: 'en',
            title: 'Telegram Account Takeover Trick',
            summary: 'Learn how Messenger impersonators try to steal Telegram login codes.',
            intro: 'You receive a Messenger message from an account that appears to belong to a friend.',
            closingSummary: 'Never share account login codes. Verify unusual requests through a separate trusted channel.',
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Step for Scenario 1
    await db.into(db.cachedScenarioSteps).insert(
          CachedScenarioStepsCompanion.insert(
            id: 'step-1-1',
            scenarioId: 'scen-1',
            stepKey: 'incoming-msg',
            kind: 'story',
            orderIndex: 1,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedStepLocalizations).insert(
          CachedStepLocalizationsCompanion.insert(
            stepId: 'step-1-1',
            locale: 'km',
            bodyText: 'សារពីមិត្តភក្តិ៖ «ជួយផ្ញើលេខកូដដែលទើបផ្ញើទៅលេខទូរស័ព្ទឯងមកខ្ញុំបន្តិច!»',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedStepLocalizations).insert(
          CachedStepLocalizationsCompanion.insert(
            stepId: 'step-1-1',
            locale: 'en',
            bodyText: 'Message from friend: "Please send me the code that was just sent to your phone!"',
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Scenario 2: Fake Online Store (Coming Soon)
    await db.into(db.cachedScenarios).insert(
          CachedScenariosCompanion.insert(
            id: 'scen-2',
            slug: 'fake-online-store',
            categoryId: 'cat-2',
            estimatedMinutes: 6,
            status: 'coming_soon',
            version: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-2',
            locale: 'km',
            title: 'ល្បិចហាងអនឡាញក្លែងក្លាយ',
            summary: 'ការបោកប្រាស់តាមទំព័រលក់ទំនិញអនឡាញដែលមានតម្លៃទាបខុសពីធម្មតា។',
            intro: 'intro',
            closingSummary: 'closing',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-2',
            locale: 'en',
            title: 'Fake Online Shop',
            summary: 'Scams involving fake online storefronts offering unrealistically cheap items.',
            intro: 'intro',
            closingSummary: 'closing',
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Scenario 3: Bank Impersonation (Coming Soon)
    await db.into(db.cachedScenarios).insert(
          CachedScenariosCompanion.insert(
            id: 'scen-3',
            slug: 'bank-impersonation',
            categoryId: 'cat-3',
            estimatedMinutes: 5,
            status: 'coming_soon',
            version: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-3',
            locale: 'km',
            title: 'ល្បិចក្លែងបន្លំធនាគារ',
            summary: 'ការហៅទូរស័ព្ទឬផ្ញើសារបន្លំជាបុគ្គលិកធនាគារដើម្បីសួររកលេខសម្ងាត់។',
            intro: 'intro',
            closingSummary: 'closing',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-3',
            locale: 'en',
            title: 'Bank Impersonation',
            summary: 'Fraudulent phone calls or SMS messages claiming to be bank staff asking for credentials.',
            intro: 'intro',
            closingSummary: 'closing',
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Scenario 4: Fake Investment (Coming Soon)
    await db.into(db.cachedScenarios).insert(
          CachedScenariosCompanion.insert(
            id: 'scen-4',
            slug: 'fake-investment',
            categoryId: 'cat-4',
            estimatedMinutes: 7,
            status: 'coming_soon',
            version: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-4',
            locale: 'km',
            title: 'ល្បិចវិនិយោគក្លែងក្លាយ',
            summary: 'ការលួងលោមឱ្យដាក់ប្រាក់វិនិយោគជាមួយការសន្យាផ្ដល់ផលចំណេញខ្ពស់មិនប្រក្រតី។',
            intro: 'intro',
            closingSummary: 'closing',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.cachedScenarioLocalizations).insert(
          CachedScenarioLocalizationsCompanion.insert(
            scenarioId: 'scen-4',
            locale: 'en',
            title: 'Fake High-Yield Investment',
            summary: 'Enticing investment schemes promising unrealistically high and guaranteed daily returns.',
            intro: 'intro',
            closingSummary: 'closing',
            createdAt: now,
            updatedAt: now,
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('1. Scenario Library displays all four cards with illustrated covers in Khmer', (tester) async {
    await tester.pumpWidget(
      ScamPlayApp(
        repository: repository,
        syncService: syncService,
        initialLocale: const Locale('km'),
      ),
    );
    await tester.pumpAndSettle();

    // Verify header
    expect(find.text('បណ្ណាល័យសេណារីយ៉ូ (Scenario Library)'), findsOneWidget);

    // Verify exactly 4 scenario cards are rendered
    expect(find.byType(ScenarioCardWidget), findsNWidgets(4));

    // Verify all 4 unique card keys and localized titles exist
    final expectedKhmerTitles = {
      'scen-1': 'ល្បិចបោកយកគណនី Telegram',
      'scen-2': 'ល្បិចហាងអនឡាញក្លែងក្លាយ',
      'scen-3': 'ល្បិចក្លែងបន្លំធនាគារ',
      'scen-4': 'ល្បិចវិនិយោគក្លែងក្លាយ',
    };

    for (final entry in expectedKhmerTitles.entries) {
      final cardFinder = find.byKey(ValueKey('scenario_card_${entry.key}'));
      final titleFinder = find.byKey(ValueKey('scenario_card_title_${entry.key}'));

      expect(cardFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(find.descendant(of: cardFinder, matching: titleFinder), findsOneWidget);
      expect((tester.widget(titleFinder) as Text).data, entry.value);
    }

    // Verify statuses
    expect(find.text('អាចមើលគំរូបាន'), findsOneWidget);
    expect(find.text('មកដល់ឆាប់ៗ'), findsNWidgets(3));
  });

  testWidgets('2. Bilingual toggle preserves all 4 cards with English content', (tester) async {
    await tester.pumpWidget(
      ScamPlayApp(
        repository: repository,
        syncService: syncService,
        initialLocale: const Locale('km'),
      ),
    );
    await tester.pumpAndSettle();

    // Verify initial Khmer state has exactly 4 cards
    expect(find.byType(ScenarioCardWidget), findsNWidgets(4));

    // Toggle to English
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Verify English header
    expect(find.text('Scenario Library'), findsOneWidget);

    // Verify exactly 4 unique scenario cards are rendered (no duplication)
    expect(find.byType(ScenarioCardWidget), findsNWidgets(4));
    expect(find.byKey(const ValueKey('scenario_card_scen-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('scenario_card_scen-2')), findsOneWidget);
    expect(find.byKey(const ValueKey('scenario_card_scen-3')), findsOneWidget);
    expect(find.byKey(const ValueKey('scenario_card_scen-4')), findsOneWidget);

    // Verify all 4 English titles exist on cards with exact 1-to-1 card matching
    final expectedEnglishTitles = {
      'scen-1': 'Telegram Account Takeover Trick',
      'scen-2': 'Fake Online Shop',
      'scen-3': 'Bank Impersonation',
      'scen-4': 'Fake High-Yield Investment',
    };

    for (final entry in expectedEnglishTitles.entries) {
      final cardFinder = find.byKey(ValueKey('scenario_card_${entry.key}'));
      final titleFinder = find.byKey(ValueKey('scenario_card_title_${entry.key}'));

      expect(cardFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(find.descendant(of: cardFinder, matching: titleFinder), findsOneWidget);
      expect((tester.widget(titleFinder) as Text).data, entry.value);
    }

    // Verify English statuses
    expect(find.text('Preview Available'), findsOneWidget);
    expect(find.text('Coming Soon'), findsNWidgets(3));

    // Verify toggling back to Khmer preserves exact 4 cards and scenario identities
    await tester.tap(find.text('ភាសាខ្មែរ'));
    await tester.pumpAndSettle();

    expect(find.byType(ScenarioCardWidget), findsNWidgets(4));
    expect(find.byKey(const ValueKey('scenario_card_scen-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('scenario_card_scen-2')), findsOneWidget);
    expect(find.byKey(const ValueKey('scenario_card_scen-3')), findsOneWidget);
    expect(find.byKey(const ValueKey('scenario_card_scen-4')), findsOneWidget);
    expect((tester.widget(find.byKey(const ValueKey('scenario_card_title_scen-3'))) as Text).data, 'ល្បិចក្លែងបន្លំធនាគារ');
  });

  testWidgets('3. Tapping available scenario navigates to ScenarioDetailScreen', (tester) async {
    await tester.pumpWidget(
      ScamPlayApp(
        repository: repository,
        syncService: syncService,
        initialLocale: const Locale('km'),
      ),
    );
    await tester.pumpAndSettle();

    // Tap Telegram card
    await tester.tap(find.text('ល្បិចបោកយកគណនី Telegram'));
    await tester.pumpAndSettle();

    // Verify ScenarioDetailScreen is pushed
    expect(find.byType(ScenarioDetailScreen), findsOneWidget);
    expect(find.text('សេចក្តីលម្អិតមេរៀន'), findsOneWidget);
    expect(find.text('អ្វីដែលអ្នកនឹងរៀន'), findsOneWidget);
    expect(find.text('រចនាសម្ព័ន្ធមេរៀន (1 ជំហាន)'), findsOneWidget);
    expect(find.text('ការអនុវត្តសាច់រឿងជាក់ស្តែង (ចាប់ផ្តើមក្នុង M4)'), findsOneWidget);
  });

  testWidgets('4. Tapping Coming Soon card displays ComingSoonSheet modal', (tester) async {
    await tester.pumpWidget(
      ScamPlayApp(
        repository: repository,
        syncService: syncService,
        initialLocale: const Locale('km'),
      ),
    );
    await tester.pumpAndSettle();

    // Scroll to Fake Online Shop card and tap it
    final targetCard = find.byKey(const ValueKey('scenario_card_scen-2'));
    await tester.ensureVisible(targetCard);
    await tester.pumpAndSettle();
    await tester.tap(targetCard);
    await tester.pumpAndSettle();

    // Verify ComingSoonSheet is displayed
    expect(find.byType(ComingSoonSheet), findsOneWidget);
    expect(find.text('មេរៀននេះកំពុងស្ថិតក្នុងការពិនិត្យខ្លឹមសារគរុកោសល្យ និងការរចនាសាច់រឿងអន្តរកម្ម។ វានឹងត្រូវដាក់ឱ្យអនុវត្តក្នុងដំណាក់កាលបន្ទាប់។'), findsOneWidget);

    // Tap dismiss button
    await tester.tap(find.text('យល់ព្រម'));
    await tester.pumpAndSettle();

    // Verify sheet is dismissed
    expect(find.byType(ComingSoonSheet), findsNothing);
  });

  testWidgets('5. Category filter chips filter cards accurately', (tester) async {
    await tester.pumpWidget(
      ScamPlayApp(
        repository: repository,
        syncService: syncService,
        initialLocale: const Locale('km'),
      ),
    );
    await tester.pumpAndSettle();

    // Tap 'ការបន្លំដណ្ដើមគណនី' chip
    await tester.tap(find.widgetWithText(ChoiceChip, 'ការបន្លំដណ្ដើមគណនី'));
    await tester.pumpAndSettle();

    // Only Telegram card should be visible
    expect(find.text('ល្បិចបោកយកគណនី Telegram'), findsOneWidget);
    expect(find.text('ល្បិចហាងអនឡាញក្លែងក្លាយ'), findsNothing);
    expect(find.text('ល្បិចក្លែងបន្លំធនាគារ'), findsNothing);

    // Tap 'ទាំងអស់' (All) chip
    await tester.tap(find.widgetWithText(ChoiceChip, 'ទាំងអស់'));
    await tester.pumpAndSettle();

    // All 4 should be visible again
    expect(find.text('ល្បិចបោកយកគណនី Telegram'), findsOneWidget);
    expect(find.text('ល្បិចហាងអនឡាញក្លែងក្លាយ'), findsOneWidget);
  });
}
