import 'package:flutter/material.dart';
import '../../data/models/scenario_models.dart';
import '../../data/repositories/content_repository.dart';
import '../theme/app_typography.dart';
import '../widgets/scenario_cover_illustration.dart';

class ScenarioDetailScreen extends StatefulWidget {
  final String scenarioId;
  final String categorySlug;
  final ContentRepository repository;
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const ScenarioDetailScreen({
    super.key,
    required this.scenarioId,
    required this.categorySlug,
    required this.repository,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  State<ScenarioDetailScreen> createState() => _ScenarioDetailScreenState();
}

class _ScenarioDetailScreenState extends State<ScenarioDetailScreen> {
  ScenarioDetailModel? _detail;
  bool _isLoading = true;

  bool get isKhmer => widget.currentLocale.languageCode == 'km';

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  @override
  void didUpdateWidget(covariant ScenarioDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocale != widget.currentLocale) {
      _loadDetail();
    }
  }

  Future<void> _loadDetail() async {
    setState(() => _isLoading = true);
    final detail = await widget.repository.getScenarioDetail(
      widget.scenarioId,
      locale: widget.currentLocale.languageCode,
    );
    if (mounted) {
      setState(() {
        _detail = detail;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isKhmer ? 'ព័ត៌មានលម្អិតអំពីសេណារីយ៉ូ' : 'Scenario Details',
          style: AppTypography.pageTitle(isKhmer: isKhmer, color: const Color(0xFF0F172A)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 48),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              icon: const Icon(Icons.language, size: 18),
              label: Text(
                isKhmer ? 'English' : 'ភាសាខ្មែរ',
                style: AppTypography.button(isKhmer: isKhmer, fontSize: 13),
              ),
              onPressed: () {
                widget.onLocaleChanged(
                  isKhmer ? const Locale('en') : const Locale('km'),
                );
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _detail == null
              ? Center(
                  child: Text(
                    isKhmer ? 'រកមិនឃើញទិន្នន័យសេណារីយ៉ូទេ' : 'Scenario not found',
                    style: AppTypography.caption(isKhmer: isKhmer),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Illustration (Responsive)
                      ScenarioCoverIllustration(
                        categorySlug: widget.categorySlug,
                        height: 160,
                      ),
                      const SizedBox(height: 16),

                      // Badges
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: const Color(0xFF93C5FD)),
                            ),
                            child: Text(
                              isKhmer ? 'អាចមើលជាមុនបាន' : 'Preview Available',
                              style: AppTypography.statusBadge(
                                isKhmer: isKhmer,
                                color: const Color(0xFF1E3A8A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              const Icon(Icons.schedule, size: 14, color: Color(0xFF64748B)),
                              const SizedBox(width: 4),
                              Text(
                                isKhmer
                                    ? '${_detail!.estimatedMinutes} នាទី'
                                    : '${_detail!.estimatedMinutes} mins',
                                style: AppTypography.caption(isKhmer: isKhmer),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Scenario Title (Kantumruy Pro)
                      Text(
                        _detail!.title,
                        style: AppTypography.pageTitle(isKhmer: isKhmer),
                      ),
                      const SizedBox(height: 10),

                      // Intro Story Callout (Battambang for Khmer body)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          _detail!.intro,
                          style: AppTypography.body(isKhmer: isKhmer),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Learning Objectives Heading (Kantumruy Pro)
                      Text(
                        isKhmer ? 'អ្វីដែលអ្នកនឹងរៀន' : 'Learning Objectives',
                        style: AppTypography.sectionHeading(isKhmer: isKhmer),
                      ),
                      const SizedBox(height: 10),
                      _buildObjectiveItem(
                        icon: Icons.lock_outline,
                        text: isKhmer
                            ? 'យល់ដឹងពីល្បិចស្នើសុំលេខកូដសម្ងាត់តាមរយៈការក្លែងបន្លំជាមិត្តភក្តិ'
                            : 'Understand how impersonators request verification codes by posing as trusted contacts.',
                      ),
                      _buildObjectiveItem(
                        icon: Icons.block,
                        text: isKhmer
                            ? 'មូលហេតុដែលមិនត្រូវចែករំលែកលេខកូដ Login ឬ OTP ដាច់ខាត'
                            : 'Why login OTP codes must never be shared under any circumstances.',
                      ),
                      _buildObjectiveItem(
                        icon: Icons.verified_user_outlined,
                        text: isKhmer
                            ? 'វិធីផ្ទៀងផ្ទាត់ដោយផ្ទាល់តាមមធ្យោបាយឯករាជ្យក្រៅពីឆាតដែលគួរឱ្យសង្ស័យ'
                            : 'Techniques to verify identity directly outside the suspicious messaging channel.',
                      ),
                      const SizedBox(height: 22),

                      // Scenario Steps Preview (Kantumruy Pro heading)
                      Text(
                        isKhmer
                            ? 'រចនាសម្ព័ន្ធសេណារីយ៉ូ (${_detail!.steps.length} ជំហាន)'
                            : 'Scenario Structure (${_detail!.steps.length} steps)',
                        style: AppTypography.sectionHeading(isKhmer: isKhmer),
                      ),
                      const SizedBox(height: 10),
                      ..._detail!.steps.map(_buildStepCard),
                      const SizedBox(height: 22),

                      // Closing Safety Advice (Battambang body)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline, color: Color(0xFFB45309), size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isKhmer ? 'គន្លឹះសុវត្ថិភាព' : 'Safety Tips',
                                    style: AppTypography.sectionHeading(
                                      isKhmer: isKhmer,
                                      color: const Color(0xFF78350F),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _detail!.closingSummary,
                                    style: AppTypography.body(
                                      isKhmer: isKhmer,
                                      fontSize: 12.5,
                                      color: const Color(0xFF78350F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // User-Facing Gameplay Button (Disabled until M4; NO internal milestone terms exposed)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: null, // Disabled per gate rules until playable scenario is verified
                          icon: const Icon(Icons.sports_esports_outlined, size: 20),
                          label: Text(
                            isKhmer
                                ? 'លេង (នឹងមកដល់ឆាប់ៗ)'
                                : 'Play (Coming Soon)',
                            style: AppTypography.button(isKhmer: isKhmer, fontSize: 14),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }

  Widget _buildObjectiveItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF1D4ED8)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body(isKhmer: isKhmer, fontSize: 13.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(ScenarioStepDetailModel step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
            child: Text(
              '${step.orderIndex}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.bodyText,
                  style: AppTypography.body(
                    isKhmer: isKhmer,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                if (step.options.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isKhmer
                          ? '${step.options.length} ជម្រើសការសម្រេចចិត្ត'
                          : '${step.options.length} decision options',
                      style: AppTypography.caption(isKhmer: isKhmer, fontSize: 11.0),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
