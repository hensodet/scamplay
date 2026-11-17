import 'package:flutter/material.dart';

/// Renders a coherent, modern, and rights-neutral vector illustration for scenario cards.
/// Avoids external proprietary logos (no Telegram, Facebook, or banking logos)
/// to maintain editorial independence and prevent trademark infringement.
class ScenarioCoverIllustration extends StatelessWidget {
  final String categorySlug;
  final double height;
  final double? width;

  const ScenarioCoverIllustration({
    super.key,
    required this.categorySlug,
    this.height = 140,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = _getCategoryTheme(categorySlug);

    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.startColor, theme.endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          // Background decorative geometric shapes
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            left: -15,
            top: -15,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Central thematic icon composition
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                theme.primaryIcon,
                size: 34,
                color: Colors.white,
              ),
            ),
          ),

          // Secondary badge icon
          Positioned(
            right: 16,
            top: 14,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                theme.secondaryIcon,
                size: 16,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static _IllustrationTheme _getCategoryTheme(String categorySlug) {
    switch (categorySlug) {
      case 'account_takeover':
      case 'impersonation':
        return const _IllustrationTheme(
          startColor: Color(0xFF1E3A8A), // Deep Navy
          endColor: Color(0xFF2563EB),   // Royal Blue
          primaryIcon: Icons.security,
          secondaryIcon: Icons.chat_bubble_outline,
        );
      case 'fake_online_store':
      case 'ecommerce':
        return const _IllustrationTheme(
          startColor: Color(0xFFB45309), // Amber 700
          endColor: Color(0xFFF59E0B),   // Amber 500
          primaryIcon: Icons.shopping_bag_outlined,
          secondaryIcon: Icons.warning_amber_rounded,
        );
      case 'bank_impersonation':
      case 'banking':
        return const _IllustrationTheme(
          startColor: Color(0xFF0F766E), // Teal 700
          endColor: Color(0xFF0D9488),   // Teal 600
          primaryIcon: Icons.account_balance,
          secondaryIcon: Icons.phone_in_talk,
        );
      case 'fake_investment':
      case 'investment':
        return const _IllustrationTheme(
          startColor: Color(0xFF4338CA), // Indigo 700
          endColor: Color(0xFF6366F1),   // Indigo 500
          primaryIcon: Icons.trending_up,
          secondaryIcon: Icons.monetization_on_outlined,
        );
      default:
        return const _IllustrationTheme(
          startColor: Color(0xFF334155), // Slate 700
          endColor: Color(0xFF64748B),   // Slate 500
          primaryIcon: Icons.shield_outlined,
          secondaryIcon: Icons.info_outline,
        );
    }
  }
}

class _IllustrationTheme {
  final Color startColor;
  final Color endColor;
  final IconData primaryIcon;
  final IconData secondaryIcon;

  const _IllustrationTheme({
    required this.startColor,
    required this.endColor,
    required this.primaryIcon,
    required this.secondaryIcon,
  });
}
