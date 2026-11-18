enum GameplaySafetyCategory {
  safe,
  caution,
  unsafe;

  static GameplaySafetyCategory fromString(String val) {
    switch (val.toLowerCase()) {
      case 'safe':
        return GameplaySafetyCategory.safe;
      case 'caution':
        return GameplaySafetyCategory.caution;
      case 'unsafe':
      default:
        return GameplaySafetyCategory.unsafe;
    }
  }

  String toDbString() {
    switch (this) {
      case GameplaySafetyCategory.safe:
        return 'safe';
      case GameplaySafetyCategory.caution:
        return 'caution';
      case GameplaySafetyCategory.unsafe:
        return 'unsafe';
    }
  }
}

class ChatMessage {
  final String id;
  final String senderName;
  final bool isUser;
  final bool isSystem;
  final String text;
  final DateTime timestamp;
  final bool isCodeAlert;

  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.isUser,
    this.isSystem = false,
    required this.text,
    required this.timestamp,
    this.isCodeAlert = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'senderName': senderName,
        'isUser': isUser,
        'isSystem': isSystem,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
        'isCodeAlert': isCodeAlert,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as String,
        senderName: json['senderName'] as String,
        isUser: json['isUser'] as bool,
        isSystem: json['isSystem'] as bool? ?? false,
        text: json['text'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        isCodeAlert: json['isCodeAlert'] as bool? ?? false,
      );
}

class GameplayDecisionOption {
  final String id;
  final String optionKey;
  final int orderIndex;
  final int scoreValue;
  final GameplaySafetyCategory safetyCategory;
  final String label;
  final String feedbackText;
  final String? nextStepKey;
  final String? simulatedReaction;

  const GameplayDecisionOption({
    required this.id,
    required this.optionKey,
    required this.orderIndex,
    required this.scoreValue,
    required this.safetyCategory,
    required this.label,
    required this.feedbackText,
    this.nextStepKey,
    this.simulatedReaction,
  });

  int get scorePercent {
    switch (safetyCategory) {
      case GameplaySafetyCategory.safe:
        return 100;
      case GameplaySafetyCategory.caution:
        return 50;
      case GameplaySafetyCategory.unsafe:
        return 0;
    }
  }
}

class GameplayStep {
  final String stepKey;
  final int stage;
  final String stageTitle;
  final List<ChatMessage> messages;
  final List<GameplayDecisionOption> options;
  final String educationalTakeaway;

  const GameplayStep({
    required this.stepKey,
    required this.stage,
    required this.stageTitle,
    required this.messages,
    required this.options,
    required this.educationalTakeaway,
  });
}

class GameplayHistoryRecord {
  final String stepKey;
  final int stage;
  final String stepPrompt;
  final String selectedOptionId;
  final String selectedOptionLabel;
  final GameplaySafetyCategory safetyCategory;
  final int scoreEarned;
  final String feedbackText;
  final DateTime timestamp;

  const GameplayHistoryRecord({
    required this.stepKey,
    required this.stage,
    required this.stepPrompt,
    required this.selectedOptionId,
    required this.selectedOptionLabel,
    required this.safetyCategory,
    required this.scoreEarned,
    required this.feedbackText,
    required this.timestamp,
  });

  GameplayHistoryRecord copyWith({
    String? stepKey,
    int? stage,
    String? stepPrompt,
    String? selectedOptionId,
    String? selectedOptionLabel,
    GameplaySafetyCategory? safetyCategory,
    int? scoreEarned,
    String? feedbackText,
    DateTime? timestamp,
  }) {
    return GameplayHistoryRecord(
      stepKey: stepKey ?? this.stepKey,
      stage: stage ?? this.stage,
      stepPrompt: stepPrompt ?? this.stepPrompt,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
      selectedOptionLabel: selectedOptionLabel ?? this.selectedOptionLabel,
      safetyCategory: safetyCategory ?? this.safetyCategory,
      scoreEarned: scoreEarned ?? this.scoreEarned,
      feedbackText: feedbackText ?? this.feedbackText,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'stepKey': stepKey,
        'stage': stage,
        'stepPrompt': stepPrompt,
        'selectedOptionId': selectedOptionId,
        'selectedOptionLabel': selectedOptionLabel,
        'safetyCategory': safetyCategory.toDbString(),
        'scoreEarned': scoreEarned,
        'feedbackText': feedbackText,
        'timestamp': timestamp.toIso8601String(),
      };

  factory GameplayHistoryRecord.fromJson(Map<String, dynamic> json) =>
      GameplayHistoryRecord(
        stepKey: json['stepKey'] as String,
        stage: json['stage'] as int,
        stepPrompt: json['stepPrompt'] as String? ?? '',
        selectedOptionId: json['selectedOptionId'] as String,
        selectedOptionLabel: json['selectedOptionLabel'] as String,
        safetyCategory:
            GameplaySafetyCategory.fromString(json['safetyCategory'] as String),
        scoreEarned: json['scoreEarned'] as int,
        feedbackText: json['feedbackText'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}

class GameplaySessionState {
  final String attemptId;
  final String scenarioId;
  final int scenarioVersion;
  final String scenarioTitle;
  final String currentStepKey;
  final int currentStage;
  final List<ChatMessage> chatMessages;
  final List<GameplayHistoryRecord> history;
  final bool isAwaitingDecision;
  final bool isShowingFeedback;
  final GameplayDecisionOption? lastDecision;
  final bool isCompleted;
  final int totalScorePercent;
  final DateTime createdAt;
  final DateTime? completedAt;

  const GameplaySessionState({
    required this.attemptId,
    required this.scenarioId,
    required this.scenarioVersion,
    required this.scenarioTitle,
    required this.currentStepKey,
    required this.currentStage,
    required this.chatMessages,
    required this.history,
    this.isAwaitingDecision = true,
    this.isShowingFeedback = false,
    this.lastDecision,
    this.isCompleted = false,
    this.totalScorePercent = 0,
    required this.createdAt,
    this.completedAt,
  });

  GameplaySessionState copyWith({
    String? scenarioTitle,
    String? currentStepKey,
    int? currentStage,
    List<ChatMessage>? chatMessages,
    List<GameplayHistoryRecord>? history,
    bool? isAwaitingDecision,
    bool? isShowingFeedback,
    GameplayDecisionOption? lastDecision,
    bool? isCompleted,
    int? totalScorePercent,
    DateTime? completedAt,
  }) {
    return GameplaySessionState(
      attemptId: attemptId,
      scenarioId: scenarioId,
      scenarioVersion: scenarioVersion,
      scenarioTitle: scenarioTitle ?? this.scenarioTitle,
      currentStepKey: currentStepKey ?? this.currentStepKey,
      currentStage: currentStage ?? this.currentStage,
      chatMessages: chatMessages ?? this.chatMessages,
      history: history ?? this.history,
      isAwaitingDecision: isAwaitingDecision ?? this.isAwaitingDecision,
      isShowingFeedback: isShowingFeedback ?? this.isShowingFeedback,
      lastDecision: lastDecision ?? this.lastDecision,
      isCompleted: isCompleted ?? this.isCompleted,
      totalScorePercent: totalScorePercent ?? this.totalScorePercent,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toAttemptJson() => {
        'attemptId': attemptId,
        'scenarioId': scenarioId,
        'scenarioVersion': scenarioVersion,
        'currentStepKey': currentStepKey,
        'currentStage': currentStage,
        'history': history.map((h) => h.toJson()).toList(),
        'chatMessages': chatMessages.map((m) => m.toJson()).toList(),
        'totalScorePercent': totalScorePercent,
        'isCompleted': isCompleted,
        'completedAt': completedAt?.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
      };
}
