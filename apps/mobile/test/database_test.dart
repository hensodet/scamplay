import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/repositories/content_repository.dart';
import 'package:mobile/data/models/scenario_models.dart';

void main() {
  late AppDatabase db;
  late DriftContentRepository repository;

  setUp(() {
    // Create fresh in-memory SQLite database for isolated unit testing
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftContentRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift SQLite Database & Repository Unit Tests', () {
    test('1. AppPreferences saves and retrieves persistent language choice', () async {
      // Default should be 'km'
      final defaultLang = await repository.getLanguagePreference();
      expect(defaultLang, equals('km'));

      // Update to English
      await repository.setLanguagePreference('en');
      final updatedLang = await repository.getLanguagePreference();
      expect(updatedLang, equals('en'));

      // Switch back to Khmer
      await repository.setLanguagePreference('km');
      final switchedBack = await repository.getLanguagePreference();
      expect(switchedBack, equals('km'));
    });

    test('2. SyncMetadata records and reads sync status', () async {
      final initial = await repository.getLastSyncTime();
      expect(initial, isNull);

      final now = DateTime.utc(2026, 11, 18, 12, 0, 0);
      await db.setSyncMetadata('content_last_synced_at', 'success', now);

      final recorded = await repository.getLastSyncTime();
      expect(recorded, isNotNull);
      expect(recorded!.millisecondsSinceEpoch, equals(now.millisecondsSinceEpoch));
    });

    test('3. GuestAttempts records local provisional score and answers', () async {
      final attemptId = 'att-test-001';
      final attempt = GuestAttemptModel(
        attemptId: attemptId,
        scenarioId: 'a0000000-0000-0000-0000-000000000001',
        scenarioVersion: 1,
        answers: {'step-1': 'opt-safe-1', 'step-2': 'opt-unsafe-2'},
        scoreLocal: 75,
        completed: true,
        completedAt: DateTime.utc(2026, 11, 18, 12, 30, 0),
        createdAt: DateTime.utc(2026, 11, 18, 12, 25, 0),
        updatedAt: DateTime.utc(2026, 11, 18, 12, 30, 0),
      );

      await repository.saveGuestAttempt(attempt);

      final attempts = await repository.getGuestAttempts();
      expect(attempts.length, equals(1));
      expect(attempts.first.attemptId, equals(attemptId));
      expect(attempts.first.scoreLocal, equals(75));
      expect(attempts.first.completed, isTrue);
      expect(attempts.first.answers['step-1'], equals('opt-safe-1'));
    });

    test('4. Scenario and Localization query returns bilingual content correctly', () async {
      // Seed minimal valid scenario data
      final categoryId = 'cat-test-001';
      final scenarioId = 'scen-test-001';
      final stepId = 'step-test-001';
      final optionId = 'opt-test-001';
      final now = DateTime.utc(2026, 11, 18, 10, 0, 0);

      await db.into(db.cachedScenarioCategories).insert(
            CachedScenarioCategoriesCompanion.insert(
              id: categoryId,
              slug: 'phishing',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedScenarioCategoryLocalizations).insert(
            CachedScenarioCategoryLocalizationsCompanion.insert(
              categoryId: categoryId,
              locale: 'km',
              name: 'សារក្លែងបន្លំ',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedScenarioCategoryLocalizations).insert(
            CachedScenarioCategoryLocalizationsCompanion.insert(
              categoryId: categoryId,
              locale: 'en',
              name: 'Phishing',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedScenarios).insert(
            CachedScenariosCompanion.insert(
              id: scenarioId,
              slug: 'test-phishing',
              categoryId: categoryId,
              estimatedMinutes: 5,
              status: 'published',
              version: const Value(1),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedScenarioLocalizations).insert(
            CachedScenarioLocalizationsCompanion.insert(
              scenarioId: scenarioId,
              locale: 'km',
              title: 'តេស្តល្បិចបោកប្រាស់',
              summary: 'សង្ខេបមេរៀនតេស្ត',
              intro: 'សេចក្តីផ្តើម',
              closingSummary: 'សេចក្តីបញ្ចប់',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedScenarioLocalizations).insert(
            CachedScenarioLocalizationsCompanion.insert(
              scenarioId: scenarioId,
              locale: 'en',
              title: 'Phishing Test Scenario',
              summary: 'Test summary in English',
              intro: 'Introduction',
              closingSummary: 'Closing summary',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedScenarioSteps).insert(
            CachedScenarioStepsCompanion.insert(
              id: stepId,
              scenarioId: scenarioId,
              stepKey: 'step-1',
              kind: 'decision',
              orderIndex: 1,
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedStepLocalizations).insert(
            CachedStepLocalizationsCompanion.insert(
              stepId: stepId,
              locale: 'km',
              bodyText: 'តើអ្នកគួរឆ្លើយតបយ៉ាងណា?',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedStepLocalizations).insert(
            CachedStepLocalizationsCompanion.insert(
              stepId: stepId,
              locale: 'en',
              bodyText: 'How should you respond?',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedAnswerOptions).insert(
            CachedAnswerOptionsCompanion.insert(
              id: optionId,
              stepId: stepId,
              optionKey: 'opt-safe',
              orderIndex: 1,
              scoreValue: const Value(100),
              safetyCategory: 'safe',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db.into(db.cachedAnswerLocalizations).insert(
            CachedAnswerLocalizationsCompanion.insert(
              optionId: optionId,
              locale: 'km',
              label: 'កុំផ្ញើលេខកូដ',
              feedbackText: 'ត្រឹមត្រូវណាស់!',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.cachedAnswerLocalizations).insert(
            CachedAnswerLocalizationsCompanion.insert(
              optionId: optionId,
              locale: 'en',
              label: 'Do not share code',
              feedbackText: 'Correct decision!',
              createdAt: now,
              updatedAt: now,
            ),
          );

      // Query cards in Khmer
      final kmCards = await repository.getScenarioCards(locale: 'km');
      expect(kmCards.length, equals(1));
      expect(kmCards.first.title, equals('តេស្តល្បិចបោកប្រាស់'));
      expect(kmCards.first.categoryName, equals('សារក្លែងបន្លំ'));
      expect(kmCards.first.isPlayable, isTrue);

      // Query cards in English
      final enCards = await repository.getScenarioCards(locale: 'en');
      expect(enCards.length, equals(1));
      expect(enCards.first.title, equals('Phishing Test Scenario'));
      expect(enCards.first.categoryName, equals('Phishing'));

      // Query detail in Khmer
      final kmDetail = await repository.getScenarioDetail(scenarioId, locale: 'km');
      expect(kmDetail, isNotNull);
      expect(kmDetail!.steps.length, equals(1));
      expect(kmDetail.steps.first.bodyText, equals('តើអ្នកគួរឆ្លើយតបយ៉ាងណា?'));
      expect(kmDetail.steps.first.options.first.label, equals('កុំផ្ញើលេខកូដ'));

      // Query detail in English
      final enDetail = await repository.getScenarioDetail(scenarioId, locale: 'en');
      expect(enDetail, isNotNull);
      expect(enDetail!.steps.length, equals(1));
      expect(enDetail.steps.first.bodyText, equals('How should you respond?'));
      expect(enDetail.steps.first.options.first.label, equals('Do not share code'));
    });

    test('5. Content cache replacement strictly preserves GuestAttempts', () async {
      // Record a guest attempt
      final attempt = GuestAttemptModel(
        attemptId: 'guest-persist-test',
        scenarioId: 'scen-test-001',
        scenarioVersion: 1,
        answers: {'q1': 'opt1'},
        scoreLocal: 100,
        completed: true,
        completedAt: DateTime.now().toUtc(),
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      );
      await repository.saveGuestAttempt(attempt);

      // Simulate a cache clear (what happens during sync)
      await db.transaction(() async {
        await db.delete(db.cachedAnswerLocalizations).go();
        await db.delete(db.cachedAnswerOptions).go();
        await db.delete(db.cachedStepLocalizations).go();
        await db.delete(db.cachedScenarioSteps).go();
        await db.delete(db.cachedScenarioLocalizations).go();
        await db.delete(db.cachedScenarios).go();
      });

      // Verify scenario count is 0
      final count = await repository.getCachedScenarioCount();
      expect(count, equals(0));

      // Verify guest attempt is completely preserved!
      final attempts = await repository.getGuestAttempts();
      expect(attempts.length, equals(1));
      expect(attempts.first.attemptId, equals('guest-persist-test'));
    });
  });
}
