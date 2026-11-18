import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/models/gameplay_models.dart';
import 'package:mobile/data/repositories/content_repository.dart';
import 'package:mobile/data/services/scenario_engine_service.dart';
import 'package:mobile/ui/screens/scenario_play_screen.dart';
import 'package:mobile/ui/screens/scenario_result_screen.dart';

void main() {
  late AppDatabase db;
  late DriftContentRepository repository;
  late ScenarioEngineService engine;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftContentRepository(db);
    engine = ScenarioEngineService(repository: repository);
  });

  tearDown(() async {
    await db.close();
  });

  group('M4 Scenario Engine Unit Tests', () {
    test('1. Loads 4-stage Telegram Takeover story with bilingual completeness', () {
      final kmStory = engine.getTelegramTakeoverStory(isKhmer: true);
      final enStory = engine.getTelegramTakeoverStory(isKhmer: false);

      expect(kmStory.length, equals(5)); // 1, 2, 3, 4_safe, 4_breach
      expect(enStory.length, equals(5));

      // Stage 1
      expect(kmStory[0].stage, equals(1));
      expect(kmStory[0].stepKey, equals('stage_1_contact'));
      expect(kmStory[0].options.length, equals(3));
      expect(kmStory[0].messages.first.text, contains('Telegram'));

      // Stage 3 contains simulated OTP SMS
      final stage3 = kmStory.firstWhere((s) => s.stepKey == 'stage_3_code_request');
      expect(stage3.messages.any((m) => m.isCodeAlert), isTrue);
      expect(stage3.messages.any((m) => m.text.contains('84920')), isTrue);
    });

    test('2. Decision evaluation calculates safe, caution, and unsafe scores accurately', () async {
      final session = await engine.initializeSession(
        scenarioId: 'c0000000-0000-4000-8000-000000000001',
        locale: 'km',
      );

      final story = engine.getTelegramTakeoverStory(isKhmer: true);
      final step1 = story.first;

      // Safe option (call friend directly) -> 100%
      final safeOpt = step1.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.safe);
      expect(safeOpt.scorePercent, equals(100));

      // Caution option -> 50%
      final cautionOpt = step1.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.caution);
      expect(cautionOpt.scorePercent, equals(50));

      // Unsafe option -> 0%
      final unsafeOpt = step1.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.unsafe);
      expect(unsafeOpt.scorePercent, equals(0));

      // Submit safe decision
      final nextState = await engine.submitDecision(
        currentState: session,
        option: safeOpt,
        isKhmer: true,
      );

      expect(nextState.history.length, equals(1));
      expect(nextState.history.first.scoreEarned, equals(100));
      expect(nextState.totalScorePercent, equals(100));
      expect(nextState.currentStepKey, equals('stage_2_urgency'));
    });

    test('3. Branching: Safe path in Stage 3 leads to Two-Step Verification protection', () async {
      var state = await engine.initializeSession(
        scenarioId: 'c0000000-0000-4000-8000-000000000001',
        locale: 'km',
      );

      final story = engine.getTelegramTakeoverStory(isKhmer: true);

      // Stage 1 -> Safe
      final opt1 = story[0].options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.safe);
      state = await engine.submitDecision(currentState: state, option: opt1, isKhmer: true);

      // Stage 2 -> Safe
      final step2 = story.firstWhere((s) => s.stepKey == state.currentStepKey);
      final opt2 = step2.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.safe);
      state = await engine.submitDecision(currentState: state, option: opt2, isKhmer: true);

      // Stage 3 -> Refuse code (Safe)
      final step3 = story.firstWhere((s) => s.stepKey == state.currentStepKey);
      final opt3 = step3.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.safe);
      state = await engine.submitDecision(currentState: state, option: opt3, isKhmer: true);

      // Must branch to stage_4_recovery_safe
      expect(state.currentStepKey, equals('stage_4_recovery_safe'));
      expect(state.currentStage, equals(4));

      // Complete stage 4
      final step4 = story.firstWhere((s) => s.stepKey == state.currentStepKey);
      final opt4 = step4.options.first;
      state = await engine.submitDecision(currentState: state, option: opt4, isKhmer: true);

      expect(state.isCompleted, isTrue);
      expect(state.totalScorePercent, equals(100));
      expect(state.completedAt, isNotNull);
    });

    test('4. Branching: Compromised path in Stage 3 branches to Incident Recovery step', () async {
      var state = await engine.initializeSession(
        scenarioId: 'c0000000-0000-4000-8000-000000000001',
        locale: 'km',
      );

      final story = engine.getTelegramTakeoverStory(isKhmer: true);

      // Stage 1 -> Safe
      final opt1 = story[0].options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.safe);
      state = await engine.submitDecision(currentState: state, option: opt1, isKhmer: true);

      // Stage 2 -> Safe
      final step2 = story.firstWhere((s) => s.stepKey == state.currentStepKey);
      final opt2 = step2.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.safe);
      state = await engine.submitDecision(currentState: state, option: opt2, isKhmer: true);

      // Stage 3 -> Share OTP code (Unsafe!)
      final step3 = story.firstWhere((s) => s.stepKey == state.currentStepKey);
      final opt3Unsafe = step3.options.firstWhere((o) => o.safetyCategory == GameplaySafetyCategory.unsafe);
      state = await engine.submitDecision(currentState: state, option: opt3Unsafe, isKhmer: true);

      // Must branch to stage_4_recovery_breach!
      expect(state.currentStepKey, equals('stage_4_recovery_breach'));
      expect(state.chatMessages.any((m) => m.text.contains('អាសន្នសុវត្ថិភាព') || m.text.contains('Security Alert')), isTrue);

      // Recovery step: Terminate sessions
      final step4Breach = story.firstWhere((s) => s.stepKey == state.currentStepKey);
      final opt4Recovery = step4Breach.options.firstWhere((o) => o.optionKey == 'terminate_sessions');
      state = await engine.submitDecision(currentState: state, option: opt4Recovery, isKhmer: true);

      expect(state.isCompleted, isTrue);
      expect(state.history.length, equals(4));
      // Average score: (100 + 100 + 0 + 100) / 4 = 75%
      expect(state.totalScorePercent, equals(75));
    });

    test('5. Local persistence: Interrupted session resumes from SQLite correctly', () async {
      final scenarioId = 'c0000000-0000-4000-8000-000000000001';
      var state = await engine.initializeSession(
        scenarioId: scenarioId,
        locale: 'km',
        forceNew: true,
      );

      final story = engine.getTelegramTakeoverStory(isKhmer: true);
      final opt1 = story[0].options.first;
      state = await engine.submitDecision(currentState: state, option: opt1, isKhmer: true);

      // Simulate app kill and restart: initializeSession(forceNew: false)
      final resumedSession = await engine.initializeSession(
        scenarioId: scenarioId,
        locale: 'km',
        forceNew: false,
      );

      expect(resumedSession.attemptId, equals(state.attemptId));
      expect(resumedSession.currentStepKey, equals('stage_2_urgency'));
      expect(resumedSession.currentStage, equals(2));
      expect(resumedSession.history.length, equals(1));
    });
  });

  group('M4 Interactive Gameplay UI Widget Tests', () {
    testWidgets('6. ScenarioPlayScreen renders simulated chat, stage progress, and evaluates decision', (tester) async {
      final scenarioId = 'c0000000-0000-4000-8000-000000000001';

      await tester.pumpWidget(
        MaterialApp(
          home: ScenarioPlayScreen(
            scenarioId: scenarioId,
            repository: repository,
            currentLocale: const Locale('km'),
            onLocaleChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Verify Simulation Notice Banner
      expect(find.textContaining('កម្មវិធីពិសោធន៍អប់រំ'), findsOneWidget);

      // 2. Verify Sender Header
      expect(find.text('សុភាព (មិត្តភក្តិ)'), findsOneWidget);

      // 3. Verify Stage 1 Progress Indicator
      expect(find.text('Stage 1/4'), findsOneWidget);

      // 4. Verify Decision Choices Rendered
      expect(find.text('ជ្រើសរើសការឆ្លើយតបរបស់អ្នក៖'), findsOneWidget);
      expect(find.text('ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់តាមលេខទូរស័ព្ទដែលធ្លាប់ស្គាល់'), findsOneWidget);

      // 5. Tap Safe Decision Option
      await tester.tap(find.text('ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់តាមលេខទូរស័ព្ទដែលធ្លាប់ស្គាល់'));
      await tester.pumpAndSettle();

      // 6. Verify Feedback Overlay is Shown with Safe (+100%) Badge
      expect(find.textContaining('ការសម្រេចចិត្តមានសុវត្ថិភាព (+100%)'), findsOneWidget);
      expect(find.textContaining('Out-of-band Verification'), findsOneWidget);

      // 7. Tap Continue Button
      expect(find.text('បន្តទៅមុខ'), findsOneWidget);
      await tester.tap(find.text('បន្តទៅមុខ'));
      await tester.pumpAndSettle();

      // 8. Progresses to Stage 2
      expect(find.text('Stage 2/4'), findsOneWidget);
    });

    testWidgets('7. ScenarioResultScreen displays score, decisions breakdown, and safety rules', (tester) async {
      final dummyState = GameplaySessionState(
        attemptId: 'att-test-final',
        scenarioId: 'scen-1',
        scenarioVersion: 1,
        scenarioTitle: 'ការលួចយកគណនី Telegram',
        currentStepKey: 'stage_4_recovery_safe',
        currentStage: 4,
        chatMessages: [],
        history: [
          GameplayHistoryRecord(
            stepKey: 'stage_1_contact',
            stage: 1,
            stepPrompt: 'Stage 1',
            selectedOptionId: 'opt_1',
            selectedOptionLabel: 'ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់',
            safetyCategory: GameplaySafetyCategory.safe,
            scoreEarned: 100,
            feedbackText: 'ការផ្ទៀងផ្ទាត់ដោយផ្ទាល់មានសុវត្ថិភាព។',
            timestamp: DateTime.now(),
          ),
          GameplayHistoryRecord(
            stepKey: 'stage_3_code_request',
            stage: 3,
            stepPrompt: 'Stage 3',
            selectedOptionId: 'opt_3',
            selectedOptionLabel: 'ដាច់ខាតមិនចែករំលែកលេខកូដ',
            safetyCategory: GameplaySafetyCategory.safe,
            scoreEarned: 100,
            feedbackText: 'ការពារកូដសម្ងាត់ជោគជ័យ។',
            timestamp: DateTime.now(),
          ),
        ],
        isCompleted: true,
        totalScorePercent: 100,
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ScenarioResultScreen(
            sessionState: dummyState,
            repository: repository,
            currentLocale: const Locale('km'),
            onLocaleChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Score and Trophy Header
      expect(find.text('100%'), findsOneWidget);
      expect(find.text('អ្នកការពារឌីជីថលឆ្នើម!'), findsOneWidget);

      // Decisions Review
      expect(find.text('ការសម្រេចចិត្តរបស់អ្នក'), findsOneWidget);
      expect(find.text('ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់'), findsOneWidget);
      expect(find.text('ដាច់ខាតមិនចែករំលែកលេខកូដ'), findsOneWidget);

      // Warning signs and Golden rules
      expect(find.text('សញ្ញាព្រមានដែលអ្នកបានរៀន'), findsOneWidget);
      expect(find.text('វិធានមាស ៣ យ៉ាងសម្រាប់សុវត្ថិភាព'), findsOneWidget);

      // Replay and Back buttons (normalized to handle U+200B word breaks)
      expect(
        find.byWidgetPredicate((w) =>
            w is Text &&
            w.data?.replaceAll('\u200B', '') == 'លេងសេណារីយ៉ូនេះម្តងទៀត'),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((w) =>
            w is Text &&
            w.data?.replaceAll('\u200B', '') == 'ត្រឡប់ទៅបណ្ណាល័យសេណារីយ៉ូ'),
        findsOneWidget,
      );
    });

    testWidgets('8. Responsive: No RenderFlex overflow at 320px viewport with 1.5x text scale', (tester) async {
      tester.view.physicalSize = const Size(320 * 2, 640 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final scenarioId = 'c0000000-0000-4000-8000-000000000001';

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(320, 640),
            textScaler: TextScaler.linear(1.5),
          ),
          child: MaterialApp(
            home: ScenarioPlayScreen(
              scenarioId: scenarioId,
              repository: repository,
              currentLocale: const Locale('km'),
              onLocaleChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ScenarioPlayScreen), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Target the actual Scrollable descendant of ListView keyed gameplay_chat_list
      final listScrollable = find.descendant(
        of: find.byKey(const Key('gameplay_chat_list')),
        matching: find.byType(Scrollable),
      );

      // Verify selecting an option at 320px with 1.5x scale does not overflow
      final safeChoiceFinder =
          find.text('ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់តាមលេខទូរស័ព្ទដែលធ្លាប់ស្គាល់');

      await tester.scrollUntilVisible(
        safeChoiceFinder,
        50.0,
        scrollable: listScrollable,
      );
      await tester.pumpAndSettle();

      expect(safeChoiceFinder, findsOneWidget);
      await tester.ensureVisible(safeChoiceFinder);
      await tester.pumpAndSettle();

      await tester.tap(safeChoiceFinder);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('ការសម្រេចចិត្តមានសុវត្ថិភាព (+100%)'), findsOneWidget);

      // Verify continuing at 320px with 1.5x scale does not overflow
      final continueBtn = find.text('បន្តទៅមុខ');
      await tester.scrollUntilVisible(
        continueBtn,
        50.0,
        scrollable: listScrollable,
      );
      await tester.pumpAndSettle();

      expect(continueBtn, findsOneWidget);
      await tester.ensureVisible(continueBtn);
      await tester.pumpAndSettle();

      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Stage 2/4'), findsOneWidget);
    });

    testWidgets('9. Responsive: English gameplay with 1.5x text scale at 320px viewport', (tester) async {
      tester.view.physicalSize = const Size(320 * 2, 640 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final scenarioId = 'c0000000-0000-4000-8000-000000000001';

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(320, 640),
            textScaler: TextScaler.linear(1.5),
          ),
          child: MaterialApp(
            home: ScenarioPlayScreen(
              scenarioId: scenarioId,
              repository: repository,
              currentLocale: const Locale('en'),
              onLocaleChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ScenarioPlayScreen), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Target the actual Scrollable descendant of ListView keyed gameplay_chat_list
      final listScrollable = find.descendant(
        of: find.byKey(const Key('gameplay_chat_list')),
        matching: find.byType(Scrollable),
      );

      // Select safe choice in English
      final choiceFinder =
          find.text('Call them directly using their known phone number');

      await tester.scrollUntilVisible(
        choiceFinder,
        50.0,
        scrollable: listScrollable,
      );
      await tester.pumpAndSettle();

      expect(choiceFinder, findsOneWidget);
      await tester.ensureVisible(choiceFinder);
      await tester.pumpAndSettle();

      await tester.tap(choiceFinder);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Safe Decision (+100%)'), findsOneWidget);

      // Advance to next stage
      final continueBtn = find.text('Continue');
      await tester.scrollUntilVisible(
        continueBtn,
        50.0,
        scrollable: listScrollable,
      );
      await tester.pumpAndSettle();

      expect(continueBtn, findsOneWidget);
      await tester.ensureVisible(continueBtn);
      await tester.pumpAndSettle();

      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Stage 2/4'), findsOneWidget);
    });

    testWidgets('10. Responsive: ScenarioResultScreen with 1.5x text scale at 320px viewport', (tester) async {
      tester.view.physicalSize = const Size(320 * 2, 640 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final dummyState = GameplaySessionState(
        attemptId: 'att-resp-result',
        scenarioId: 'scen-1',
        scenarioVersion: 1,
        scenarioTitle: 'ការលួចយកគណនី Telegram',
        currentStepKey: 'stage_4_recovery_safe',
        currentStage: 4,
        chatMessages: [],
        history: [
          GameplayHistoryRecord(
            stepKey: 'stage_1_contact',
            stage: 1,
            stepPrompt: 'Stage 1',
            selectedOptionId: 'opt_1',
            selectedOptionLabel:
                'ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់តាមលេខទូរស័ព្ទដែលធ្លាប់ស្គាល់',
            safetyCategory: GameplaySafetyCategory.safe,
            scoreEarned: 100,
            feedbackText: 'ការផ្ទៀងផ្ទាត់ដោយផ្ទាល់មានសុវត្ថិភាពខ្ពស់។',
            timestamp: DateTime.now(),
          ),
        ],
        isCompleted: true,
        totalScorePercent: 100,
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(320, 640),
            textScaler: TextScaler.linear(1.5),
          ),
          child: MaterialApp(
            home: ScenarioResultScreen(
              sessionState: dummyState,
              repository: repository,
              currentLocale: const Locale('km'),
              onLocaleChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ScenarioResultScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('11. Language switching mid-gameplay retranslates all messages, choices, feedback, and title while preserving attempt progress', (tester) async {
      final scenarioId = 'c0000000-0000-4000-8000-000000000001';
      Locale activeLocale = const Locale('km');

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return ScenarioPlayScreen(
                scenarioId: scenarioId,
                repository: repository,
                currentLocale: activeLocale,
                onLocaleChanged: (newLoc) {
                  setState(() => activeLocale = newLoc);
                },
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Initially in Khmer
      expect(find.text('សុភាព (មិត្តភក្តិ)'), findsOneWidget);
      expect(find.text('ដំណាក់កាលទី ១៖ ទំនាក់ទំនងគួរឱ្យសង្ស័យ'), findsOneWidget);
      expect(find.textContaining('សួស្តី! សុខសប្បាយទេ?'), findsOneWidget);

      // Select first safe choice in Khmer
      final safeChoiceFinder =
          find.text('ទូរស័ព្ទទៅសួរគាត់ផ្ទាល់តាមលេខទូរស័ព្ទដែលធ្លាប់ស្គាល់');
      await tester.ensureVisible(safeChoiceFinder);
      await tester.pumpAndSettle();
      await tester.tap(safeChoiceFinder);
      await tester.pumpAndSettle();

      // Feedback shown in Khmer
      expect(find.text('ការសម្រេចចិត្តមានសុវត្ថិភាព (+100%)'), findsOneWidget);
      expect(find.text('បន្តទៅមុខ'), findsOneWidget);

      final attemptsBefore = await repository.getGuestAttempts();
      expect(attemptsBefore.isNotEmpty, isTrue);
      final initialAttemptId = attemptsBefore.first.attemptId;
      expect(attemptsBefore.first.scoreLocal, equals(100));

      // Switch language to English via stable widget key
      final langBtn = find.byKey(const ValueKey('language_switch_button'));
      expect(langBtn, findsOneWidget);
      await tester.tap(langBtn);
      await tester.pumpAndSettle();

      // Verified: Contact and Stage Title retranslated to English
      expect(find.text('Sopheap (Friend)'), findsOneWidget);
      expect(find.text('Stage 2: Urgency & Pressure'), findsOneWidget);
      expect(find.text('Stage 2/4'), findsOneWidget);

      // Verified: Chat messages retranslated to English
      expect(find.textContaining('Hi! How are you? I have an urgent issue'), findsOneWidget);
      expect(find.text('Call them directly using their known phone number'), findsOneWidget);

      // Verified: Feedback retranslated to English while preserving progress
      expect(find.text('Safe Decision (+100%)'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);

      // Verify active attempt ID, score, and history are preserved
      final attemptsAfterEn = await repository.getGuestAttempts();
      expect(attemptsAfterEn.first.attemptId, equals(initialAttemptId));
      expect(attemptsAfterEn.first.scoreLocal, equals(100));

      // Switch back to Khmer via same stable button
      await tester.tap(langBtn);
      await tester.pumpAndSettle();

      // Verified: Retranslated back to Khmer cleanly
      expect(find.text('សុភាព (មិត្តភក្តិ)'), findsOneWidget);
      expect(find.text('ដំណាក់កាលទី ២៖ សម្ពាធបន្ទាន់ និងការលួងលោម'), findsOneWidget);
      expect(find.text('Stage 2/4'), findsOneWidget);
      expect(find.textContaining('សួស្តី! សុខសប្បាយទេ?'), findsOneWidget);
      expect(find.text('ការសម្រេចចិត្តមានសុវត្ថិភាព (+100%)'), findsOneWidget);
      expect(find.text('បន្តទៅមុខ'), findsOneWidget);

      final attemptsAfterKm = await repository.getGuestAttempts();
      expect(attemptsAfterKm.first.attemptId, equals(initialAttemptId));
      expect(attemptsAfterKm.first.scoreLocal, equals(100));

      // Tap Continue in Khmer -> Advance to Stage 2
      final continueBtn = find.text('បន្តទៅមុខ');
      await tester.ensureVisible(continueBtn);
      await tester.pumpAndSettle();
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(find.text('Stage 2/4'), findsOneWidget);
      expect(find.textContaining('ម៉ាក់ខ្ញុំកំពុងឈឺនៅមន្ទីរពេទ្យ'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('12. Replay creates a brand new distinct attempt rather than resuming completed attempt', (tester) async {
      final scenarioId = 'c0000000-0000-4000-8000-000000000001';

      // 1. Create and complete an initial attempt
      final session1 = await engine.initializeSession(
        scenarioId: scenarioId,
        locale: 'km',
      );
      final initialAttemptId = session1.attemptId;

      final story = engine.getTelegramTakeoverStory(isKhmer: true);
      var state = session1;
      for (final stepKey in [
        'stage_1_contact',
        'stage_2_urgency',
        'stage_3_code_request',
        'stage_4_recovery_safe'
      ]) {
        final step = story.firstWhere((s) => s.stepKey == stepKey);
        final opt = step.options.firstWhere(
            (o) => o.safetyCategory == GameplaySafetyCategory.safe);
        state = await engine.submitDecision(
          currentState: state,
          option: opt,
          isKhmer: true,
        );
        state = engine.dismissFeedback(state);
      }
      expect(state.isCompleted, isTrue);

      // 2. Render ScenarioResultScreen and tap Replay
      await tester.pumpWidget(
        MaterialApp(
          home: ScenarioResultScreen(
            sessionState: state,
            repository: repository,
            currentLocale: const Locale('km'),
            onLocaleChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find Replay button and scroll until visible
      final replayBtn = find.byWidgetPredicate((w) =>
          w is Text &&
          w.data?.replaceAll('\u200B', '') == 'លេងសេណារីយ៉ូនេះម្តងទៀត');

      await tester.scrollUntilVisible(
        replayBtn,
        100.0,
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();

      expect(replayBtn, findsOneWidget);
      await tester.ensureVisible(replayBtn);
      await tester.pumpAndSettle();

      await tester.tap(replayBtn);
      await tester.pumpAndSettle();

      // Verified: Navigated to ScenarioPlayScreen with fresh attempt
      expect(find.byType(ScenarioPlayScreen), findsOneWidget);
      expect(find.text('Stage 1/4'), findsOneWidget);

      // Verify that engine has 2 attempts stored, and the new one is not completed
      final attempts = await repository.getGuestAttempts();
      expect(attempts.length, equals(2));

      final oldCompleted =
          attempts.firstWhere((a) => a.attemptId == initialAttemptId);
      expect(oldCompleted.completed, isTrue);
      expect(oldCompleted.scoreLocal, equals(100));

      final replayedAttempt =
          attempts.firstWhere((a) => a.attemptId != initialAttemptId);
      expect(replayedAttempt.completed, isFalse);
      expect(replayedAttempt.scoreLocal, equals(0));
    });
  });
}
