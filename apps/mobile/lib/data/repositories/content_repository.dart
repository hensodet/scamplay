import 'dart:convert';
import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/scenario_models.dart';

abstract class ContentRepository {
  Future<List<ScenarioCardModel>> getScenarioCards({required String locale});
  Future<ScenarioDetailModel?> getScenarioDetail(String scenarioId, {required String locale});
  Future<void> saveGuestAttempt(GuestAttemptModel attempt);
  Future<List<GuestAttemptModel>> getGuestAttempts();
  Future<String> getLanguagePreference();
  Future<void> setLanguagePreference(String locale);
  Future<DateTime?> getLastSyncTime();
  Future<int> getCachedScenarioCount();
}

class DriftContentRepository implements ContentRepository {
  final AppDatabase db;

  DriftContentRepository(this.db);

  @override
  Future<List<ScenarioCardModel>> getScenarioCards({required String locale}) async {
    // Select scenarios with matching localization
    final query = db.select(db.cachedScenarios).join([
      innerJoin(
        db.cachedScenarioLocalizations,
        db.cachedScenarioLocalizations.scenarioId.equalsExp(db.cachedScenarios.id) &
            db.cachedScenarioLocalizations.locale.equals(locale),
      ),
      leftOuterJoin(
        db.cachedScenarioCategories,
        db.cachedScenarioCategories.id.equalsExp(db.cachedScenarios.categoryId),
      ),
      leftOuterJoin(
        db.cachedScenarioCategoryLocalizations,
        db.cachedScenarioCategoryLocalizations.categoryId.equalsExp(db.cachedScenarios.categoryId) &
            db.cachedScenarioCategoryLocalizations.locale.equals(locale),
      ),
    ]);

    // Order by scenario category sortOrder, then status ('published' first), then estimatedMinutes
    query.orderBy([
      OrderingTerm.asc(db.cachedScenarioCategories.sortOrder),
      OrderingTerm.asc(db.cachedScenarios.estimatedMinutes),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final scenario = row.readTable(db.cachedScenarios);
      final localization = row.readTable(db.cachedScenarioLocalizations);
      final category = row.readTableOrNull(db.cachedScenarioCategories);
      final categoryLocalization = row.readTableOrNull(db.cachedScenarioCategoryLocalizations);

      final categorySlug = category?.slug ?? 'general';
      final categoryName = categoryLocalization?.name ??
          (locale == 'km' ? 'សុវត្ថិភាពឌីជីថល' : 'Digital Safety');

      return ScenarioCardModel(
        id: scenario.id,
        slug: scenario.slug,
        categoryId: scenario.categoryId,
        categorySlug: categorySlug,
        categoryName: categoryName,
        title: localization.title,
        summary: localization.summary,
        estimatedMinutes: scenario.estimatedMinutes,
        status: scenario.status,
        version: scenario.version,
        isPlayable: scenario.status == 'published',
        coverPath: null,
      );
    }).toList();
  }

  @override
  Future<ScenarioDetailModel?> getScenarioDetail(String scenarioId, {required String locale}) async {
    final scenarioQuery = db.select(db.cachedScenarios).join([
      innerJoin(
        db.cachedScenarioLocalizations,
        db.cachedScenarioLocalizations.scenarioId.equalsExp(db.cachedScenarios.id) &
            db.cachedScenarioLocalizations.locale.equals(locale),
      ),
    ])..where(db.cachedScenarios.id.equals(scenarioId));

    final scenarioRow = await scenarioQuery.getSingleOrNull();
    if (scenarioRow == null) return null;

    final scenario = scenarioRow.readTable(db.cachedScenarios);
    final localization = scenarioRow.readTable(db.cachedScenarioLocalizations);

    // Fetch steps
    final stepsQuery = db.select(db.cachedScenarioSteps).join([
      innerJoin(
        db.cachedStepLocalizations,
        db.cachedStepLocalizations.stepId.equalsExp(db.cachedScenarioSteps.id) &
            db.cachedStepLocalizations.locale.equals(locale),
      ),
    ])
      ..where(db.cachedScenarioSteps.scenarioId.equals(scenarioId))
      ..orderBy([OrderingTerm.asc(db.cachedScenarioSteps.orderIndex)]);

    final stepRows = await stepsQuery.get();

    final List<ScenarioStepDetailModel> steps = [];
    for (final stepRow in stepRows) {
      final step = stepRow.readTable(db.cachedScenarioSteps);
      final stepLoc = stepRow.readTable(db.cachedStepLocalizations);

      // Fetch options for this step
      final optionsQuery = db.select(db.cachedAnswerOptions).join([
        innerJoin(
          db.cachedAnswerLocalizations,
          db.cachedAnswerLocalizations.optionId.equalsExp(db.cachedAnswerOptions.id) &
              db.cachedAnswerLocalizations.locale.equals(locale),
        ),
      ])
        ..where(db.cachedAnswerOptions.stepId.equals(step.id))
        ..orderBy([OrderingTerm.asc(db.cachedAnswerOptions.orderIndex)]);

      final optionRows = await optionsQuery.get();
      final List<AnswerOptionDetailModel> options = optionRows.map((optRow) {
        final opt = optRow.readTable(db.cachedAnswerOptions);
        final optLoc = optRow.readTable(db.cachedAnswerLocalizations);
        return AnswerOptionDetailModel(
          id: opt.id,
          optionKey: opt.optionKey,
          orderIndex: opt.orderIndex,
          scoreValue: opt.scoreValue,
          safetyCategory: opt.safetyCategory,
          label: optLoc.label,
          feedbackText: optLoc.feedbackText,
          nextStepId: opt.nextStepId,
        );
      }).toList();

      steps.add(ScenarioStepDetailModel(
        id: step.id,
        stepKey: step.stepKey,
        kind: step.kind,
        orderIndex: step.orderIndex,
        bodyText: stepLoc.bodyText,
        mediaAssetId: step.mediaAssetId,
        options: options,
      ));
    }

    return ScenarioDetailModel(
      id: scenario.id,
      slug: scenario.slug,
      categoryId: scenario.categoryId,
      estimatedMinutes: scenario.estimatedMinutes,
      status: scenario.status,
      version: scenario.version,
      title: localization.title,
      summary: localization.summary,
      intro: localization.intro,
      closingSummary: localization.closingSummary,
      steps: steps,
    );
  }

  @override
  Future<void> saveGuestAttempt(GuestAttemptModel attempt) async {
    await db.recordGuestAttempt(
      GuestAttemptsCompanion(
        attemptId: Value(attempt.attemptId),
        scenarioId: Value(attempt.scenarioId),
        scenarioVersion: Value(attempt.scenarioVersion),
        answersJson: Value(jsonEncode(attempt.answers)),
        scoreLocal: Value(attempt.scoreLocal),
        completed: Value(attempt.completed),
        completedAt: Value(attempt.completedAt),
        createdAt: Value(attempt.createdAt),
        updatedAt: Value(attempt.updatedAt),
      ),
    );
  }

  @override
  Future<List<GuestAttemptModel>> getGuestAttempts() async {
    final rows = await db.getAllGuestAttempts();
    return rows.map((row) {
      Map<String, dynamic> answers = {};
      try {
        answers = jsonDecode(row.answersJson) as Map<String, dynamic>;
      } catch (_) {}

      return GuestAttemptModel(
        attemptId: row.attemptId,
        scenarioId: row.scenarioId,
        scenarioVersion: row.scenarioVersion,
        answers: answers,
        scoreLocal: row.scoreLocal,
        completed: row.completed,
        completedAt: row.completedAt,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
    }).toList();
  }

  @override
  Future<String> getLanguagePreference() async {
    final pref = await db.getPreference('app_locale');
    if (pref == 'en' || pref == 'km') {
      return pref!;
    }
    return 'km'; // Default is Khmer per project rules
  }

  @override
  Future<void> setLanguagePreference(String locale) async {
    if (locale == 'km' || locale == 'en') {
      await db.setPreference('app_locale', locale);
    }
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final meta = await db.getSyncMetadata('content_last_synced_at');
    return meta?.lastSyncedAt;
  }

  @override
  Future<int> getCachedScenarioCount() async {
    final count = await db.cachedScenarios.count().getSingle();
    return count;
  }
}
