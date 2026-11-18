import 'package:flutter/material.dart';
import '../../data/models/gameplay_models.dart';
import '../../data/repositories/content_repository.dart';
import '../theme/app_typography.dart';
import 'scenario_play_screen.dart';

class ScenarioResultScreen extends StatelessWidget {
  final GameplaySessionState sessionState;
  final ContentRepository repository;
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const ScenarioResultScreen({
    super.key,
    required this.sessionState,
    required this.repository,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  bool get isKhmer => currentLocale.languageCode == 'km';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isNarrow = screenWidth < 360;

    final score = sessionState.totalScorePercent;
    final isMaster = score >= 85;
    final isPassing = score >= 50 && score < 85;

    final badgeColor = isMaster
        ? const Color(0xFF059669) // Emerald 600
        : (isPassing ? const Color(0xFFD97706) : const Color(0xFFDC2626));

    final badgeBg = isMaster
        ? const Color(0xFFECFDF5)
        : (isPassing ? const Color(0xFFFFFBEB) : const Color(0xFFFEF2F2));

    final title = isMaster
        ? (isKhmer ? 'អ្នកការពារឌីជីថលឆ្នើម!' : 'Digital Safety Champion!')
        : (isPassing
            ? (isKhmer ? 'ការអនុវត្តបានល្អគួរសម!' : 'Good Effort!')
            : (isKhmer
                ? 'ត្រូវការបង្កើនការប្រុងប្រយ័ត្ន!'
                : 'More Vigilance Needed!'));

    final subtitle = isMaster
        ? (isKhmer
            ? 'អ្នកបានធ្វើការសម្រេចចិត្តប្រកបដោយសុវត្ថិភាពខ្ពស់ និងបានការពារគណនីរបស់អ្នកពីចោរបានជោគជ័យ។'
            : 'You made high-safety decisions and successfully protected your account from takeover.')
        : (isPassing
            ? (isKhmer
                ? 'អ្នកបានបង្ហាញការសង្ស័យល្អ ប៉ុន្តែនៅតែមានចំណុចហានិភ័យដែលអាចឱ្យជនខិលខូចកេងចំណេញបាន។'
                : 'You showed healthy caution, but a few gaps could still leave your account vulnerable.')
            : (isKhmer
                ? 'អ្នកបានធ្លាក់ក្នុងអន្ទាក់លួចលេខកូដសម្ងាត់។ សូមពិនិត្យមើលមេរៀនខាងក្រោម ដើម្បីកុំឱ្យចាញ់បោកក្នុងជីវិតពិត!'
                : 'You fell for the verification code lure. Review the safety lessons below to stay safe in real life!'));

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        titleSpacing: isNarrow ? 0.0 : 8.0,
        title: Text(
          isKhmer ? 'លទ្ធផល និងមេរៀនសុវត្ថិភាព' : 'Results & Safety Lessons',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: isKhmer
                ? AppTypography.fontKantumruyPro
                : AppTypography.fontInter,
            fontWeight: FontWeight.w700,
            fontSize: isNarrow ? 17.0 : 20.0,
            color: const Color(0xFF0F172A),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Semantics(
              label: isKhmer ? 'Switch to English' : 'ប្តូរទៅភាសាខ្មែរ',
              button: true,
              child: TextButton.icon(
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
                  onLocaleChanged(
                    isKhmer ? const Locale('en') : const Locale('km'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Result Score Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        shape: BoxShape.circle,
                        border: Border.all(color: badgeColor, width: 2.0),
                      ),
                      child: Icon(
                        isMaster
                            ? Icons.verified_user
                            : (isPassing
                                ? Icons.shield_outlined
                                : Icons.gpp_maybe_outlined),
                        size: 38.0,
                        color: badgeColor,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      '$score%',
                      style: AppTypography.scoreDisplay(color: badgeColor),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      title,
                      style: AppTypography.feedbackTitle(
                        isKhmer: isKhmer,
                        color: const Color(0xFF0F172A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      subtitle,
                      style: AppTypography.body(isKhmer: isKhmer),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // 2. Decisions Review
              Text(
                isKhmer ? 'ការសម្រេចចិត្តរបស់អ្នក' : 'Your Decisions Breakdown',
                style: AppTypography.sectionHeading(isKhmer: isKhmer),
              ),
              const SizedBox(height: 10.0),
              ...sessionState.history.map((record) => _buildDecisionCard(record)),

              const SizedBox(height: 20.0),

              // 3. Warning Signs Breakdown
              _buildWarningSignsCard(),

              const SizedBox(height: 20.0),

              // 4. Golden Rules for Digital Safety
              _buildGoldenRulesCard(),

              const SizedBox(height: 24.0),

              // 5. Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ScenarioPlayScreen(
                          scenarioId: sessionState.scenarioId,
                          repository: repository,
                          currentLocale: currentLocale,
                          onLocaleChanged: onLocaleChanged,
                          forceNew: true,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.replay, size: 20),
                      const SizedBox(height: 4.0),
                      Text(
                        isKhmer
                            ? 'លេង\u200Bសេណារីយ៉ូ\u200Bនេះ\u200Bម្តងទៀត'
                            : 'Replay This Scenario',
                        textAlign: TextAlign.center,
                        style: AppTypography.button(
                          isKhmer: isKhmer,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    minimumSize: const Size(double.infinity, 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 20),
                      const SizedBox(height: 4.0),
                      Text(
                        isKhmer
                            ? 'ត្រឡប់ទៅ\u200Bបណ្ណាល័យ\u200Bសេណារីយ៉ូ'
                            : 'Back to Scenario Library',
                        textAlign: TextAlign.center,
                        style: AppTypography.button(isKhmer: isKhmer),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecisionCard(GameplayHistoryRecord record) {
    final isSafe = record.safetyCategory == GameplaySafetyCategory.safe;
    final isCaution = record.safetyCategory == GameplaySafetyCategory.caution;

    final Color badgeColor = isSafe
        ? const Color(0xFF059669)
        : (isCaution ? const Color(0xFFD97706) : const Color(0xFFDC2626));

    final Color badgeBg = isSafe
        ? const Color(0xFFECFDF5)
        : (isCaution ? const Color(0xFFFFFBEB) : const Color(0xFFFEF2F2));

    final String statusLabel = isSafe
        ? (isKhmer ? 'សុវត្ថិភាព (+100%)' : 'Safe (+100%)')
        : (isCaution
            ? (isKhmer ? 'ប្រុងប្រយ័ត្ន (+50%)' : 'Caution (+50%)')
            : (isKhmer ? 'ហានិភ័យ (0%)' : 'Unsafe (0%)'));

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stage ${record.stage}',
                style: const TextStyle(
                  fontFamily: AppTypography.fontInter,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    statusLabel,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: isKhmer
                          ? AppTypography.fontKantumruyPro
                          : AppTypography.fontInter,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: badgeColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            record.selectedOptionLabel,
            style: AppTypography.choiceText(isKhmer: isKhmer),
          ),
          const SizedBox(height: 6.0),
          Text(
            record.feedbackText,
            style: AppTypography.body(
              isKhmer: isKhmer,
              fontSize: 14.5,
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningSignsCard() {
    final signs = isKhmer
        ? [
            'សារពីគណនីដែលអះអាងថាជាមិត្តភក្តិ តែប្រើទូរស័ព្ទអ្នកដទៃ ឬមានសំដីខុសពីធម្មតា។',
            'ការបង្កើតសម្ពាធបន្ទាន់ ដូចជាបញ្ហាគ្រួសារ ឬមន្ទីរពេទ្យ ដើម្បីកុំឱ្យអ្នកមានពេលគិត។',
            'ការស្នើសុំលេខកូដ Login ឬ OTP ដែលផ្ញើមកកាន់ទូរស័ព្ទរបស់អ្នក។',
          ]
        : [
            'Messages claiming to be friends from unfamiliar accounts or with unusual tone.',
            'Manufactured urgent crises (hospital emergencies) to force panic reactions.',
            'Any request for login authentication codes or OTPs sent to your phone.',
          ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB), // Amber 50
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: Color(0xFFB45309), size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  isKhmer ? 'សញ្ញាព្រមានដែលអ្នកបានរៀន' : 'Warning Signs to Remember',
                  style: AppTypography.sectionHeading(
                    isKhmer: isKhmer,
                    color: const Color(0xFF78350F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...signs.map(
            (sign) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(
                          color: Color(0xFFB45309),
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      sign,
                      style: AppTypography.body(
                        isKhmer: isKhmer,
                        fontSize: 14.5,
                        color: const Color(0xFF78350F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoldenRulesCard() {
    final rules = isKhmer
        ? [
            'ដាច់ខាតកុំចែករំលែកលេខកូដ Login / OTP ឱ្យអ្នកណាឡើយ សូម្បីតែមិត្តភក្តិជិតស្និទ្ធ។',
            'ផ្ទៀងផ្ទាត់ការសុំជំនួយបន្ទាន់តាមរយៈការទូរស័ព្ទផ្ទាល់ ឬសួរមនុស្សជុំវិញខ្លួន។',
            'បើកដំណើរការ Two-Step Verification ក្នុង Telegram (Settings > Privacy and Security)។',
          ]
        : [
            'Never share Telegram login OTP codes with anyone, under any circumstances.',
            'Always verify emergency requests by directly calling the known phone number.',
            'Enable Two-Step Verification in Telegram Settings > Privacy and Security.',
          ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // Blue 50
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user_outlined,
                  color: Color(0xFF1D4ED8), size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  isKhmer
                      ? 'វិធានមាស ៣ យ៉ាងសម្រាប់សុវត្ថិភាព'
                      : '3 Golden Rules for Digital Safety',
                  style: AppTypography.sectionHeading(
                    isKhmer: isKhmer,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...rules.map(
            (rule) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('✓ ',
                      style: TextStyle(
                          color: Color(0xFF1D4ED8),
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      rule,
                      style: AppTypography.body(
                        isKhmer: isKhmer,
                        fontSize: 14.5,
                        color: const Color(0xFF1E3A8A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
