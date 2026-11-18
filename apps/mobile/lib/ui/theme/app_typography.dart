import 'package:flutter/material.dart';

/// Centralized, coherent bilingual typography system for ScamPlay.
///
/// Headings:
/// - Khmer: Kantumruy Pro (semi-bold 600 / bold 700), modern sans-serif with high legibility.
/// - English: Inter (semi-bold 600 / bold 700).
///
/// Body & Educational Descriptions:
/// - Khmer: Battambang (regular 400 / medium 500), traditional Khmer reading face with generous line heights.
/// - English: Inter (regular 400 / medium 500).
///
/// Fallback chains ensure numbers, symbols, Latin script, and mixed Khmer-English phrases render cleanly.
class AppTypography {
  static const String fontKantumruyPro = 'KantumruyPro';
  static const String fontBattambang = 'Battambang';
  static const String fontInter = 'Inter';

  static const List<String> khmerHeadingFallback = [fontInter, 'sans-serif'];
  static const List<String> khmerBodyFallback = [fontKantumruyPro, fontInter, 'sans-serif'];
  static const List<String> englishHeadingFallback = [fontKantumruyPro, 'sans-serif'];
  static const List<String> englishBodyFallback = [fontBattambang, 'sans-serif'];

  /// Page title (e.g. "Scenario Library" / "បណ្ណាល័យសេណារីយ៉ូ")
  static TextStyle pageTitle({required bool isKhmer, Color? color}) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      height: 1.35,
      color: color ?? const Color(0xFF0F172A),
    );
  }

  /// Section heading (e.g. "Learning Objectives" / "អ្វីដែលអ្នកនឹងរៀន")
  static TextStyle sectionHeading({required bool isKhmer, Color? color}) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      height: 1.35,
      color: color ?? const Color(0xFF0F172A),
    );
  }

  /// Scenario Card title
  static TextStyle cardTitle({required bool isKhmer, Color? color}) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      height: 1.35,
      color: color ?? const Color(0xFF0F172A),
    );
  }

  /// Body text for descriptions, intros, and explanations (Battambang for Khmer)
  static TextStyle body({
    required bool isKhmer,
    double fontSize = 16.5,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontBattambang : fontInter,
      fontFamilyFallback: isKhmer ? khmerBodyFallback : englishBodyFallback,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height ?? (isKhmer ? 1.60 : 1.50),
      color: color ?? const Color(0xFF334155),
    );
  }

  /// Card educational summary
  static TextStyle cardSummary({required bool isKhmer, Color? color}) {
    return TextStyle(
      fontFamily: isKhmer ? fontBattambang : fontInter,
      fontFamilyFallback: isKhmer ? khmerBodyFallback : englishBodyFallback,
      fontSize: 15.5,
      fontWeight: FontWeight.w400,
      height: isKhmer ? 1.55 : 1.45,
      color: color ?? const Color(0xFF475569),
    );
  }

  /// Interactive button label (Kantumruy Pro for Khmer)
  static TextStyle button({
    required bool isKhmer,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.3,
      color: color,
    );
  }

  /// Category chip or filter label
  static TextStyle chip({
    required bool isKhmer,
    bool isSelected = false,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 14.5,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      height: 1.3,
      color: color ?? (isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF334155)),
    );
  }

  /// Status badge label (e.g. "Available for Preview", "Coming Soon")
  static TextStyle statusBadge({
    required bool isKhmer,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: color,
    );
  }

  /// Subtitle or secondary caption
  static TextStyle caption({
    required bool isKhmer,
    double fontSize = 14.0,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontBattambang : fontInter,
      fontFamilyFallback: isKhmer ? khmerBodyFallback : englishBodyFallback,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: isKhmer ? 1.50 : 1.40,
      color: color ?? const Color(0xFF64748B),
    );
  }

  /// Conversational dialogue message bubble text (M4 gameplay)
  static TextStyle chatMessage({
    required bool isKhmer,
    required bool isUser,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontBattambang : fontInter,
      fontFamilyFallback: isKhmer ? khmerBodyFallback : englishBodyFallback,
      fontSize: 16.5,
      fontWeight: FontWeight.w400,
      height: isKhmer ? 1.60 : 1.50,
      color: color ?? (isUser ? Colors.white : const Color(0xFF0F172A)),
    );
  }

  /// Interactive decision choice card text (M4 gameplay)
  static TextStyle choiceText({
    required bool isKhmer,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 16.5,
      fontWeight: FontWeight.w600,
      height: 1.38,
      color: color ?? const Color(0xFF0F172A),
    );
  }

  /// Educational outcome feedback title (M4 gameplay)
  static TextStyle feedbackTitle({
    required bool isKhmer,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontKantumruyPro : fontInter,
      fontFamilyFallback: isKhmer ? khmerHeadingFallback : englishHeadingFallback,
      fontSize: 19.0,
      fontWeight: FontWeight.w700,
      height: 1.35,
      color: color,
    );
  }

  /// Educational feedback explanation body (M4 gameplay)
  static TextStyle feedbackBody({
    required bool isKhmer,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: isKhmer ? fontBattambang : fontInter,
      fontFamilyFallback: isKhmer ? khmerBodyFallback : englishBodyFallback,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: isKhmer ? 1.60 : 1.50,
      color: color ?? const Color(0xFF1E293B),
    );
  }

  /// Big score percentage display (M4 completion screen)
  static TextStyle scoreDisplay({Color? color}) {
    return TextStyle(
      fontFamily: fontInter,
      fontFamilyFallback: englishHeadingFallback,
      fontSize: 36.0,
      fontWeight: FontWeight.w800,
      height: 1.2,
      color: color ?? const Color(0xFF1E3A8A),
    );
  }
}
