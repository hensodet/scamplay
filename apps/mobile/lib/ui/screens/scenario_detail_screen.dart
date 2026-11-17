import 'package:flutter/material.dart';
import '../../data/models/scenario_models.dart';
import '../../data/repositories/content_repository.dart';
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
          isKhmer ? 'សេចក្តីលម្អិតមេរៀន' : 'Scenario Preview',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.language),
            label: Text(
              isKhmer ? 'English' : 'ភាសាខ្មែរ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              widget.onLocaleChanged(
                isKhmer ? const Locale('en') : const Locale('km'),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _detail == null
              ? Center(
                  child: Text(
                    isKhmer ? 'រកមិនឃើញទិន្នន័យមេរៀនទេ' : 'Scenario not found',
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Illustration
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
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.blue.shade300),
                            ),
                            child: Text(
                              isKhmer ? 'ដំណើរការក្នុង M4' : 'Playable after M4',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                isKhmer
                                    ? '${_detail!.estimatedMinutes} នាទី'
                                    : '${_detail!.estimatedMinutes} mins',
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        _detail!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Intro
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          _detail!.intro,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Learning Objectives
                      Text(
                        isKhmer ? 'អ្វីដែលអ្នកនឹងរៀន' : 'What you will learn',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
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
                      const SizedBox(height: 20),

                      // Scenario Steps Preview
                      Text(
                        isKhmer
                            ? 'រចនាសម្ព័ន្ធមេរៀន (${_detail!.steps.length} ជំហាន)'
                            : 'Lesson Structure (${_detail!.steps.length} steps)',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      ..._detail!.steps.map(_buildStepCard),
                      const SizedBox(height: 20),

                      // Closing Advice
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber.shade300),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline, color: Colors.amber),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isKhmer ? 'សារដាស់តឿនសុវត្ថិភាព' : 'Safety Takeaway',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.amber.shade900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _detail!.closingSummary,
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: Colors.amber.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // M4 Gameplay Gate Notice Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: null, // Disabled in M3 per gate rules
                          icon: const Icon(Icons.sports_esports_outlined),
                          label: Text(
                            isKhmer
                                ? 'ការអនុវត្តសាច់រឿងជាក់ស្តែង (ចាប់ផ្តើមក្នុង M4)'
                                : 'Interactive Gameplay (Begins in M4)',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
    );
  }

  Widget _buildObjectiveItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF1E3A8A)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, height: 1.4, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(ScenarioStepDetailModel step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
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
                  style: const TextStyle(fontSize: 13, height: 1.3, fontWeight: FontWeight.w500),
                ),
                if (step.options.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    isKhmer
                        ? '${step.options.length} ជម្រើសការសម្រេចចិត្ត'
                        : '${step.options.length} decision options',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
