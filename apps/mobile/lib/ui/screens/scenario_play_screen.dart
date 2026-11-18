import 'package:flutter/material.dart';
import '../../data/models/gameplay_models.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/services/scenario_engine_service.dart';
import '../theme/app_typography.dart';
import 'scenario_result_screen.dart';

class ScenarioPlayScreen extends StatefulWidget {
  final String scenarioId;
  final ContentRepository repository;
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;
  final bool forceNew;

  const ScenarioPlayScreen({
    super.key,
    required this.scenarioId,
    required this.repository,
    required this.currentLocale,
    required this.onLocaleChanged,
    this.forceNew = false,
  });

  @override
  State<ScenarioPlayScreen> createState() => _ScenarioPlayScreenState();
}

class _ScenarioPlayScreenState extends State<ScenarioPlayScreen> {
  late final ScenarioEngineService _engineService;
  final ScrollController _scrollController = ScrollController();

  Locale? _activeLocale;
  Locale get currentLocale => _activeLocale ?? widget.currentLocale;
  bool get isKhmer => currentLocale.languageCode == 'km';

  GameplaySessionState? _sessionState;
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _activeLocale = widget.currentLocale;
    _engineService = ScenarioEngineService(repository: widget.repository);
    _initializeSession(forceNew: widget.forceNew);
  }

  @override
  void didUpdateWidget(covariant ScenarioPlayScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocale.languageCode !=
        widget.currentLocale.languageCode) {
      _activeLocale = widget.currentLocale;
      if (_sessionState != null) {
        setState(() {
          _sessionState = _engineService.retranslateSession(
            state: _sessionState!,
            isKhmer: isKhmer,
          );
        });
      }
    }
  }

  Future<void> _initializeSession({bool forceNew = false}) async {
    setState(() => _isLoading = true);
    final session = await _engineService.initializeSession(
      scenarioId: widget.scenarioId,
      locale: widget.currentLocale.languageCode,
      forceNew: forceNew,
    );

    if (mounted) {
      setState(() {
        _sessionState = session;
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleDecisionSelected(GameplayDecisionOption option) async {
    if (_isSubmitting || _sessionState == null) return;

    setState(() => _isSubmitting = true);

    final updatedState = await _engineService.submitDecision(
      currentState: _sessionState!,
      option: option,
      isKhmer: isKhmer,
    );

    if (mounted) {
      setState(() {
        _sessionState = updatedState;
        _isSubmitting = false;
      });
      _scrollToBottom();
    }
  }

  void _handleContinue() {
    if (_sessionState == null) return;

    if (_sessionState!.isCompleted) {
      // Navigate to results screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ScenarioResultScreen(
            sessionState: _sessionState!,
            repository: widget.repository,
            currentLocale: currentLocale,
            onLocaleChanged: widget.onLocaleChanged,
          ),
        ),
      );
    } else {
      setState(() {
        _sessionState = _engineService.dismissFeedback(_sessionState!);
      });
      _scrollToBottom();
    }
  }

  GameplayStep? _getCurrentStep() {
    if (_sessionState == null) return null;
    final story = _engineService.getTelegramTakeoverStory(isKhmer: isKhmer);
    return story.firstWhere(
      (s) => s.stepKey == _sessionState!.currentStepKey,
      orElse: () => story.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 100
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // 1. Simulation Warning Notice Banner (Pinned at top)
                  _buildSimulationBanner(),

                  // 2. Stage Progress Header (Pinned at top)
                  _buildProgressHeader(),

                  // 3. Unified Scrollable Gameplay Body (Chat Messages + Interactive Decision/Feedback Panel)
                  Expanded(
                    child: ListView(
                      key: const Key('gameplay_chat_list'),
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      children: [
                        ..._sessionState!.chatMessages
                            .map((msg) => _buildChatBubble(msg)),
                        const SizedBox(height: 12.0),
                        if (_sessionState!.isShowingFeedback &&
                            _sessionState!.lastDecision != null)
                          _buildFeedbackPanel(_sessionState!.lastDecision!)
                        else if (_sessionState!.isAwaitingDecision)
                          _buildDecisionPanel(),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isNarrow = screenWidth < 360;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: false,
      titleSpacing: isNarrow ? 0.0 : 8.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
        tooltip: isKhmer ? 'ត្រឡប់ក្រោយ' : 'Back',
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: isNarrow ? 15 : 17,
            backgroundColor: const Color(0xFF2563EB).withValues(alpha: 0.15),
            child: Icon(Icons.person,
                color: const Color(0xFF1D4ED8), size: isNarrow ? 17 : 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isKhmer ? 'សុភាព (មិត្តភក្តិ)' : 'Sopheap (Friend)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTypography.fontKantumruyPro,
                    fontWeight: FontWeight.w700,
                    fontSize: isNarrow ? 15.0 : 16.5,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  isKhmer ? 'សារតាម Messenger' : 'via Messenger',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption(
                    isKhmer: isKhmer,
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Semantics(
            label: isKhmer ? 'Switch to English' : 'ប្តូរទៅភាសាខ្មែរ',
            button: true,
            child: TextButton.icon(
              key: const ValueKey('language_switch_button'),
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 48),
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 6 : 8,
                  vertical: 6,
                ),
              ),
              icon: const Icon(Icons.language, size: 16),
              label: Text(
                isNarrow
                    ? (isKhmer ? 'EN' : 'ខ្មែរ')
                    : (isKhmer ? 'English' : 'ភាសាខ្មែរ'),
                style: AppTypography.button(
                  isKhmer: isKhmer,
                  fontSize: isNarrow ? 13.5 : 14.5,
                ),
              ),
              onPressed: () {
                final targetLocale =
                    isKhmer ? const Locale('en') : const Locale('km');
                widget.onLocaleChanged(targetLocale);
                setState(() {
                  _activeLocale = targetLocale;
                  if (_sessionState != null) {
                    _sessionState = _engineService.retranslateSession(
                      state: _sessionState!,
                      isKhmer: targetLocale.languageCode == 'km',
                    );
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimulationBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFEF3C7), // Amber 100
        border: Border(bottom: BorderSide(color: Color(0xFFFDE68A))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, size: 14.0, color: Color(0xFF92400E)),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              isKhmer
                  ? 'កម្មវិធីពិសោធន៍អប់រំ • សេណារីយ៉ូឆបោក (ពុំមែន Telegram ពិតប្រាកដឡើយ)'
                  : 'Educational Simulation • Scam Scenario (Not a real Telegram app)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: isKhmer
                    ? AppTypography.fontKantumruyPro
                    : AppTypography.fontInter,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF78350F),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    final stage = _sessionState?.currentStage ?? 1;
    final progress = stage / 4.0;
    final currentStep = _getCurrentStep();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  currentStep?.stageTitle ??
                      (isKhmer
                          ? 'ដំណាក់កាលទី $stage នៃ ៤'
                          : 'Stage $stage of 4'),
                  style: AppTypography.caption(
                    isKhmer: isKhmer,
                    fontSize: 13.5,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'Stage $stage/4',
                  style: const TextStyle(
                    fontFamily: AppTypography.fontInter,
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
              minHeight: 5.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg) {
    if (msg.isSystem) {
      return _buildSystemNoticeBubble(msg);
    }

    final isUser = msg.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFFCBD5E1),
              child: const Icon(Icons.person, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8.0),
          ],
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color(0xFF1E3A8A) // Deep Navy
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: Radius.circular(isUser ? 16.0 : 4.0),
                  bottomRight: Radius.circular(isUser ? 4.0 : 16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.text,
                    style: AppTypography.chatMessage(
                      isKhmer: isKhmer,
                      isUser: isUser,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    _formatTime(msg.timestamp),
                    style: TextStyle(
                      fontFamily: AppTypography.fontInter,
                      fontSize: 10.5,
                      color: isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Widget _buildSystemNoticeBubble(ChatMessage msg) {
    final isAlert = msg.isCodeAlert;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(12.0),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isAlert
              ? const Color(0xFFFFF1F2) // Rose 50
              : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isAlert
                ? const Color(0xFFFECDD3)
                : const Color(0xFFCBD5E1),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isAlert ? Icons.sms_failed_outlined : Icons.info_outline,
                  size: 16.0,
                  color: isAlert
                      ? const Color(0xFFE11D48)
                      : const Color(0xFF475569),
                ),
                const SizedBox(width: 6.0),
                Flexible(
                  child: Text(
                    msg.senderName,
                    style: TextStyle(
                      fontFamily: AppTypography.fontInter,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: isAlert
                          ? const Color(0xFF9F1239)
                          : const Color(0xFF334155),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              msg.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: isKhmer
                    ? AppTypography.fontBattambang
                    : AppTypography.fontInter,
                fontSize: 14.0,
                height: 1.45,
                fontWeight: isAlert ? FontWeight.w600 : FontWeight.w400,
                color: isAlert
                    ? const Color(0xFF881337)
                    : const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecisionPanel() {
    final currentStep = _getCurrentStep();
    if (currentStep == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.touch_app_outlined,
                  size: 18.0, color: Color(0xFF1E3A8A)),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  isKhmer
                      ? 'ជ្រើសរើសការឆ្លើយតបរបស់អ្នក៖'
                      : 'Choose your decision:',
                  style: TextStyle(
                    fontFamily: isKhmer
                        ? AppTypography.fontKantumruyPro
                        : AppTypography.fontInter,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          ...currentStep.options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => _handleDecisionSelected(option),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 12.0,
                    ),
                    side: const BorderSide(
                      color: Color(0xFFCBD5E1),
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color(0xFFF8FAFC),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      option.label,
                      style: AppTypography.choiceText(isKhmer: isKhmer),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeedbackPanel(GameplayDecisionOption option) {
    final isSafe = option.safetyCategory == GameplaySafetyCategory.safe;
    final isCaution = option.safetyCategory == GameplaySafetyCategory.caution;

    final Color bgColor = isSafe
        ? const Color(0xFFECFDF5) // Green 50
        : (isCaution ? const Color(0xFFFFFBEB) : const Color(0xFFFEF2F2));

    final Color borderColor = isSafe
        ? const Color(0xFFA7F3D0)
        : (isCaution ? const Color(0xFFFDE68A) : const Color(0xFFFECACA));

    final Color textColor = isSafe
        ? const Color(0xFF065F46)
        : (isCaution ? const Color(0xFF92400E) : const Color(0xFF991B1B));

    final IconData icon = isSafe
        ? Icons.check_circle_outline
        : (isCaution ? Icons.warning_amber_rounded : Icons.cancel_outlined);

    final String title = isSafe
        ? (isKhmer
            ? 'ការសម្រេចចិត្តមានសុវត្ថិភាព (+100%)'
            : 'Safe Decision (+100%)')
        : (isCaution
            ? (isKhmer
                ? 'ការសម្រេចចិត្តគួរប្រុងប្រយ័ត្ន (+50%)'
                : 'Cautionary Decision (+50%)')
            : (isKhmer
                ? 'ការសម្រេចចិត្តមានហានិភ័យ (0%)'
                : 'High-Risk Decision (0%)'));

    final isCompleted = _sessionState?.isCompleted ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Outcome Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: 20.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.feedbackTitle(
                      isKhmer: isKhmer,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // 2. Feedback Explanation
          Text(
            option.feedbackText,
            style: AppTypography.feedbackBody(isKhmer: isKhmer),
          ),
          const SizedBox(height: 16.0),

          // 3. Continue / View Results Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _handleContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                isCompleted
                    ? (isKhmer
                        ? 'មើលលទ្ធផល និងមេរៀនសុវត្ថិភាព'
                        : 'View Results & Safety Lessons')
                    : (isKhmer ? 'បន្តទៅមុខ' : 'Continue'),
                style: AppTypography.button(isKhmer: isKhmer, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    final h = local.hour > 12
        ? local.hour - 12
        : (local.hour == 0 ? 12 : local.hour);
    final m = local.minute.toString().padLeft(2, '0');
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }
}
