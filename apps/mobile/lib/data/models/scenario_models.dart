class ScenarioCardModel {
  final String id;
  final String slug;
  final String categoryId;
  final String categorySlug;
  final String categoryName;
  final String title;
  final String summary;
  final int estimatedMinutes;
  final String status;
  final int version;
  final bool isPlayable;
  final String? coverPath;

  const ScenarioCardModel({
    required this.id,
    required this.slug,
    required this.categoryId,
    required this.categorySlug,
    required this.categoryName,
    required this.title,
    required this.summary,
    required this.estimatedMinutes,
    required this.status,
    required this.version,
    required this.isPlayable,
    this.coverPath,
  });
}

class ScenarioDetailModel {
  final String id;
  final String slug;
  final String categoryId;
  final int estimatedMinutes;
  final String status;
  final int version;
  final String title;
  final String summary;
  final String intro;
  final String closingSummary;
  final List<ScenarioStepDetailModel> steps;

  const ScenarioDetailModel({
    required this.id,
    required this.slug,
    required this.categoryId,
    required this.estimatedMinutes,
    required this.status,
    required this.version,
    required this.title,
    required this.summary,
    required this.intro,
    required this.closingSummary,
    required this.steps,
  });
}

class ScenarioStepDetailModel {
  final String id;
  final String stepKey;
  final String kind; // 'story', 'decision', 'feedback'
  final int orderIndex;
  final String bodyText;
  final String? mediaAssetId;
  final List<AnswerOptionDetailModel> options;

  const ScenarioStepDetailModel({
    required this.id,
    required this.stepKey,
    required this.kind,
    required this.orderIndex,
    required this.bodyText,
    this.mediaAssetId,
    required this.options,
  });
}

class AnswerOptionDetailModel {
  final String id;
  final String optionKey;
  final int orderIndex;
  final int scoreValue;
  final String safetyCategory; // 'safe', 'unsafe', 'caution'
  final String label;
  final String feedbackText;
  final String? nextStepId;

  const AnswerOptionDetailModel({
    required this.id,
    required this.optionKey,
    required this.orderIndex,
    required this.scoreValue,
    required this.safetyCategory,
    required this.label,
    required this.feedbackText,
    this.nextStepId,
  });
}

class GuestAttemptModel {
  final String attemptId;
  final String scenarioId;
  final int scenarioVersion;
  final Map<String, dynamic> answers;
  final int scoreLocal;
  final bool completed;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GuestAttemptModel({
    required this.attemptId,
    required this.scenarioId,
    required this.scenarioVersion,
    required this.answers,
    required this.scoreLocal,
    required this.completed,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
}
