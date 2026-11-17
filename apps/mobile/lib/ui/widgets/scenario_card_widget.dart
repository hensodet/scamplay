import 'package:flutter/material.dart';
import '../../data/models/scenario_models.dart';
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
        ? (isKhmer ? 'អាចមើលគំរូបាន' : 'Preview Available')
        : (isKhmer ? 'មកដល់ឆាប់ៗ' : 'Coming Soon');

    return Semantics(
      label: '${card.title}, ${card.categoryName}, $statusText',
      button: true,
      child: Card(
        key: ValueKey('scenario_card_card_${card.id}'),
        elevation: isPlayable ? 3.0 : 1.5,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isPlayable ? const Color(0xFF2563EB).withValues(alpha: 0.3) : Colors.grey.shade200,
            width: isPlayable ? 1.5 : 1.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Illustrated Header
              ScenarioCoverIllustration(
                categorySlug: card.categorySlug,
                height: 120,
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
                        Chip(
                          key: ValueKey('scenario_card_category_${card.id}'),
                          label: Text(
                            card.categoryName,
                            style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                        ),
                        Container(
                          key: ValueKey('scenario_card_status_${card.id}'),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isPlayable ? Colors.blue.shade50 : Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: isPlayable ? Colors.blue.shade300 : Colors.amber.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPlayable ? Icons.visibility_outlined : Icons.hourglass_empty,
                                size: 12.0,
                                color: isPlayable ? Colors.blue.shade900 : Colors.amber.shade900,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: isPlayable ? Colors.blue.shade900 : Colors.amber.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),

                    // Title
                    Text(
                      card.title,
                      key: ValueKey('scenario_card_title_${card.id}'),
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6.0),

                    // Educational Summary
                    Text(
                      card.summary,
                      key: ValueKey('scenario_card_summary_${card.id}'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.0,
                        height: 1.4,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 14.0),

                    // Footer with Duration & Action Hint
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 15.0, color: Colors.grey.shade600),
                            const SizedBox(width: 4.0),
                            Text(
                              isKhmer
                                  ? '${card.estimatedMinutes} នាទី'
                                  : '${card.estimatedMinutes} mins',
                              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              isPlayable
                                  ? (isKhmer ? 'មើលគំរូ' : 'Preview')
                                  : (isKhmer ? 'ព័ត៌មានបន្ថែម' : 'Learn more'),
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: isPlayable ? const Color(0xFF1E3A8A) : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(width: 2.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 11.0,
                              color: isPlayable ? const Color(0xFF1E3A8A) : Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ],
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
