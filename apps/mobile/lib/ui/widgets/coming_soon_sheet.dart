import 'package:flutter/material.dart';
import '../../data/models/scenario_models.dart';
import '../theme/app_typography.dart';
import 'scenario_cover_illustration.dart';

class ComingSoonSheet extends StatelessWidget {
  final ScenarioCardModel card;
  final bool isKhmer;

  const ComingSoonSheet({
    super.key,
    required this.card,
    required this.isKhmer,
  });

  static void show(BuildContext context, ScenarioCardModel card, bool isKhmer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ComingSoonSheet(card: card, isKhmer: isKhmer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Illustration thumbnail (Scales cleanly without overflow)
          ScenarioCoverIllustration(
            categorySlug: card.categorySlug,
            height: 110,
          ),
          const SizedBox(height: 16),

          // Status & Category chips
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.hourglass_top, size: 13, color: Color(0xFFB45309)),
                    const SizedBox(width: 4),
                    Text(
                      isKhmer ? 'នឹងមកដល់ឆាប់ៗ' : 'Coming Soon',
                      style: AppTypography.statusBadge(
                        isKhmer: isKhmer,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Chip(
                  label: Text(
                    card.categoryName,
                    style: AppTypography.chip(isKhmer: isKhmer),
                    overflow: TextOverflow.ellipsis,
                  ),
                  visualDensity: VisualDensity.compact,
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title (Kantumruy Pro)
          Text(
            card.title,
            style: AppTypography.pageTitle(isKhmer: isKhmer),
          ),
          const SizedBox(height: 8),

          // Summary (Battambang)
          Text(
            card.summary,
            style: AppTypography.body(isKhmer: isKhmer),
          ),
          const SizedBox(height: 16),

          // Educational Roadmap explanation (Battambang)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.school_outlined, size: 18, color: Color(0xFF1E3A8A)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isKhmer
                        ? 'សេណារីយ៉ូនេះកំពុងស្ថិតក្នុងការពិនិត្យខ្លឹមសារគរុកោសល្យ និងការរចនាសាច់រឿងអន្តរកម្ម។ វានឹងត្រូវដាក់ឱ្យអនុវត្តក្នុងដំណាក់កាលបន្ទាប់។'
                        : 'This scenario is currently undergoing pedagogical review and interactive storyline design. It will be playable in an upcoming release.',
                    style: AppTypography.body(
                      isKhmer: isKhmer,
                      fontSize: 12.5,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Dismiss Button (Kantumruy Pro)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                isKhmer ? 'យល់ព្រម' : 'Got it',
                style: AppTypography.button(
                  isKhmer: isKhmer,
                  fontSize: 14.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
