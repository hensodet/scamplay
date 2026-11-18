import 'package:flutter/material.dart';
import '../../data/models/scenario_models.dart';
import '../theme/app_typography.dart';
import 'scenario_cover_illustration.dart';

class ScenarioCardWidget extends StatelessWidget {
  final ScenarioCardModel card;
  final bool isKhmer;
  final VoidCallback onTap;

  const ScenarioCardWidget({
    super.key,
    required this.card,
    required this.isKhmer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPlayable = card.isPlayable;
    final statusText = isPlayable
        ? (isKhmer ? 'អាចមើលជាមុនបាន' : 'Preview Available')
        : (isKhmer ? 'នឹងមកដល់ឆាប់ៗ' : 'Coming Soon');

    final actionHint = isPlayable
        ? (isKhmer ? 'មើលជាមុន' : 'Preview')
        : (isKhmer ? 'ព័ត៌មានបន្ថែម' : 'Learn more');

    return Semantics(
      label: '${card.title}, ${card.categoryName}, $statusText',
      button: true,
      child: Card(
        key: ValueKey('scenario_card_card_${card.id}'),
        elevation: isPlayable ? 2.5 : 1.0,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isPlayable
                ? const Color(0xFF2563EB).withValues(alpha: 0.35)
                : const Color(0xFFE2E8F0),
            width: isPlayable ? 1.5 : 1.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Illustrated Header
              ScenarioCoverIllustration(
                categorySlug: card.categorySlug,
                height: 135,
              ),

              // 2. Card Body
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category & Status Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Chip(
                            key: ValueKey('scenario_card_category_${card.id}'),
                            label: Text(
                              card.categoryName,
                              style: AppTypography.chip(isKhmer: isKhmer),
                              overflow: TextOverflow.ellipsis,
                            ),
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          key: ValueKey('scenario_card_status_${card.id}'),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isPlayable
                                ? const Color(0xFFEFF6FF)
                                : const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: isPlayable
                                  ? const Color(0xFF93C5FD)
                                  : const Color(0xFFFDE68A),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPlayable ? Icons.visibility_outlined : Icons.hourglass_top,
                                size: 13.0,
                                color: isPlayable
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFFB45309),
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                statusText,
                                style: AppTypography.statusBadge(
                                  isKhmer: isKhmer,
                                  color: isPlayable
                                      ? const Color(0xFF1E3A8A)
                                      : const Color(0xFFB45309),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),

                    // Title (Kantumruy Pro for Khmer)
                    Text(
                      card.title,
                      key: ValueKey('scenario_card_title_${card.id}'),
                      style: AppTypography.cardTitle(isKhmer: isKhmer),
                    ),
                    const SizedBox(height: 6.0),

                    // Educational Summary (Battambang for Khmer)
                    Text(
                      card.summary,
                      key: ValueKey('scenario_card_summary_${card.id}'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardSummary(isKhmer: isKhmer),
                    ),
                    const SizedBox(height: 14.0),

                    // Footer with Duration & Action Hint (Adaptive responsive wrap for narrow viewports)
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 6.0,
                        spacing: 8.0,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.schedule, size: 15.0, color: Color(0xFF64748B)),
                              const SizedBox(width: 4.0),
                              Text(
                                isKhmer
                                    ? '${card.estimatedMinutes} នាទី'
                                    : '${card.estimatedMinutes} mins',
                                style: AppTypography.caption(isKhmer: isKhmer),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                actionHint,
                                style: AppTypography.button(
                                  isKhmer: isKhmer,
                                  fontSize: 12.5,
                                  color: isPlayable
                                      ? const Color(0xFF1D4ED8)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(width: 2.0),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 11.0,
                                color: isPlayable
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFF64748B),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
