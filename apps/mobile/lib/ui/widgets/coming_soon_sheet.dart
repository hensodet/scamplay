import 'package:flutter/material.dart';
import '../../data/models/scenario_models.dart';
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Illustration thumbnail
          ScenarioCoverIllustration(
            categorySlug: card.categorySlug,
            height: 100,
          ),
          const SizedBox(height: 16),

          // Status & Category chips
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.hourglass_top, size: 14, color: Colors.amber.shade900),
                    const SizedBox(width: 4),
                    Text(
                      isKhmer ? 'មកដល់ឆាប់ៗ' : 'Coming Soon',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text(
                  card.categoryName,
                  style: const TextStyle(fontSize: 11),
                ),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            card.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Summary
          Text(
            card.summary,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),

          // Educational Roadmap explanation
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blueGrey.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.school_outlined, size: 18, color: Colors.blueGrey.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isKhmer
                        ? 'មេរៀននេះកំពុងស្ថិតក្នុងការពិនិត្យខ្លឹមសារគរុកោសល្យ និងការរចនាសាច់រឿងអន្តរកម្ម។ វានឹងត្រូវដាក់ឱ្យអនុវត្តក្នុងដំណាក់កាលបន្ទាប់។'
                        : 'This lesson scenario is currently undergoing pedagogical review and interactive storyline design. It will be playable in an upcoming release.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Dismiss Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isKhmer ? 'យល់ព្រម' : 'Got it',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
