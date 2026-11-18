import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

/// Renders a coherent, descriptive, and rights-neutral vector illustration for scenario cards.
/// Avoids proprietary logos (no Telegram paper airplane, no Facebook 'f', no real bank logos,
/// and no police insignia) to maintain editorial independence and copyright compliance.
///
/// Responsive architecture:
/// - Uses [CustomPainter] and Canvas geometry for decorative scenes.
/// - Completely decouples artwork from nested [Row] and [Column] layouts.
/// - Scales dynamically to any container size (card header, modal thumbnail, hero detail)
///   without ever throwing a [RenderFlex] overflow exception.
/// - Preserves accessibility semantics via [Semantics].
class ScenarioCoverIllustration extends StatelessWidget {
  final String categorySlug;
  final double height;
  final double? width;

  const ScenarioCoverIllustration({
    super.key,
    required this.categorySlug,
    this.height = 135,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = _getCategoryTheme(categorySlug);

    return Semantics(
      label: theme.semanticLabel,
      image: true,
      child: Container(
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
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background ambient lighting circles
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.07),
                ),
              ),
            ),
            Positioned(
              left: -25,
              bottom: -25,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.12),
                ),
              ),
            ),

            // Scalable vector scene drawn via CustomPainter (zero RenderFlex, zero layout overflows)
            Positioned.fill(
              child: CustomPaint(
                painter: _CategoryScenePainter(categorySlug: categorySlug),
              ),
            ),

            // Top-right category pill badge
            Positioned(
              top: 8,
              right: 10,
              child: MediaQuery.withNoTextScaling(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25), width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(theme.categoryIcon, size: 11, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        theme.badgeText,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontInter,
                          fontSize: 9.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static _IllustrationTheme _getCategoryTheme(String categorySlug) {
    switch (categorySlug) {
      case 'account_takeover':
      case 'impersonation':
        return const _IllustrationTheme(
          startColor: Color(0xFF0F172A), // Slate 900
          endColor: Color(0xFF1D4ED8),   // Blue 700
          categoryIcon: Icons.security,
          badgeText: 'SECURITY',
          semanticLabel: 'Account takeover scam illustration showing suspicious code request in messaging app',
        );
      case 'fake_online_store':
      case 'ecommerce':
        return const _IllustrationTheme(
          startColor: Color(0xFF7C2D12), // Orange 900
          endColor: Color(0xFFD97706),   // Amber 600
          categoryIcon: Icons.shopping_bag_outlined,
          badgeText: 'SHOPPING',
          semanticLabel: 'Fake online store scam illustration showing suspicious price discount and unverified seller',
        );
      case 'bank_impersonation':
      case 'banking':
        return const _IllustrationTheme(
          startColor: Color(0xFF042F2E), // Teal 950
          endColor: Color(0xFF0F766E),   // Teal 700
          categoryIcon: Icons.account_balance,
          badgeText: 'BANKING',
          semanticLabel: 'Bank impersonation scam illustration showing fake support caller requesting PIN',
        );
      case 'fake_investment':
      case 'investment':
        return const _IllustrationTheme(
          startColor: Color(0xFF1E1B4B), // Indigo 950
          endColor: Color(0xFF4F46E5),   // Indigo 600
          categoryIcon: Icons.trending_up,
          badgeText: 'INVESTMENT',
          semanticLabel: 'Fake investment scam illustration showing unrealistic return spike and caution warning',
        );
      default:
        return const _IllustrationTheme(
          startColor: Color(0xFF1E293B),
          endColor: Color(0xFF475569),
          categoryIcon: Icons.shield_outlined,
          badgeText: 'SCAM DEFENSE',
          semanticLabel: 'Digital safety scenario illustration',
        );
    }
  }
}

class _IllustrationTheme {
  final Color startColor;
  final Color endColor;
  final IconData categoryIcon;
  final String badgeText;
  final String semanticLabel;

  const _IllustrationTheme({
    required this.startColor,
    required this.endColor,
    required this.categoryIcon,
    required this.badgeText,
    required this.semanticLabel,
  });
}

class _CategoryScenePainter extends CustomPainter {
  final String categorySlug;

  const _CategoryScenePainter({required this.categorySlug});

  @override
  void paint(Canvas canvas, Size size) {
    switch (categorySlug) {
      case 'account_takeover':
      case 'impersonation':
        _paintAccountTakeover(canvas, size);
        break;
      case 'fake_online_store':
      case 'ecommerce':
        _paintFakeOnlineStore(canvas, size);
        break;
      case 'bank_impersonation':
      case 'banking':
        _paintBankImpersonation(canvas, size);
        break;
      case 'fake_investment':
      case 'investment':
        _paintFakeInvestment(canvas, size);
        break;
      default:
        _paintDefaultScene(canvas, size);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _CategoryScenePainter oldDelegate) {
    return oldDelegate.categorySlug != categorySlug;
  }

  // 1. Account Takeover: Smartphone mockup with OTP verification dots and security shield
  void _paintAccountTakeover(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // --- Left / Center: Smartphone Mockup ---
    final phoneW = math.min(w * 0.40, 126.0);
    final phoneH = h * 0.72;
    final phoneCenter = Offset(w * 0.36, h * 0.52);
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: phoneCenter, width: phoneW, height: phoneH),
      const Radius.circular(9.0),
    );

    // Phone shadow
    canvas.drawRRect(
      phoneRect.shift(const Offset(0, 3)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Phone chassis
    canvas.drawRRect(
      phoneRect,
      Paint()..color = const Color(0xFF0F172A)..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      phoneRect,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    // Phone speaker notch at top
    final notchW = phoneW * 0.28;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(phoneCenter.dx, phoneCenter.dy - phoneH * 0.43),
          width: notchW,
          height: 2.5,
        ),
        const Radius.circular(1.5),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.3),
    );

    // Message bubble (incoming from fake friend asking for OTP)
    final msgW = phoneW * 0.82;
    final msgH = phoneH * 0.38;
    final msgCenter = Offset(phoneCenter.dx, phoneCenter.dy - phoneH * 0.08);
    final msgRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: msgCenter, width: msgW, height: msgH),
      const Radius.circular(6.0),
    );
    canvas.drawRRect(msgRRect, Paint()..color = const Color(0xFF1E293B));

    // Avatar icon inside message bubble
    canvas.drawCircle(
      Offset(msgCenter.dx - msgW * 0.34, msgCenter.dy),
      msgH * 0.24,
      Paint()..color = const Color(0xFF3B82F6),
    );
    canvas.drawCircle(
      Offset(msgCenter.dx - msgW * 0.34, msgCenter.dy - msgH * 0.06),
      msgH * 0.10,
      Paint()..color = Colors.white,
    );

    // 4 OTP Code verification dots • • • •
    final dotsCenterX = msgCenter.dx + msgW * 0.04;
    final dotSpacing = msgW * 0.13;
    final dotRadius = math.min(msgH * 0.12, 3.2);
    final dotPaint = Paint()..color = const Color(0xFFFBBF24)..style = PaintingStyle.fill;
    for (int i = 0; i < 4; i++) {
      final dx = dotsCenterX + (i - 1.5) * dotSpacing;
      canvas.drawCircle(Offset(dx, msgCenter.dy), dotRadius, dotPaint);
    }

    // Small red warning indicator pill at bottom of phone screen
    final alertPillW = phoneW * 0.65;
    final alertPillH = phoneH * 0.16;
    final alertPillCenter = Offset(phoneCenter.dx, phoneCenter.dy + phoneH * 0.28);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: alertPillCenter, width: alertPillW, height: alertPillH),
        const Radius.circular(3.0),
      ),
      Paint()..color = const Color(0x33DC2626),
    );
    _drawExclamationMark(canvas, alertPillCenter, size: alertPillH * 0.65, color: const Color(0xFFF87171));

    // --- Right: Security Shield Emblem ---
    final shieldCenter = Offset(w * 0.72, h * 0.50);
    final shieldW = math.min(h * 0.54, 58.0);
    final shieldH = shieldW * 1.18;

    // Glowing circle behind shield
    canvas.drawCircle(
      shieldCenter,
      shieldW * 0.75,
      Paint()..color = Colors.white.withValues(alpha: 0.10),
    );

    // Shield path
    final shieldPath = Path();
    final sw = shieldW / 2;
    final sh = shieldH / 2;
    shieldPath.moveTo(shieldCenter.dx - sw, shieldCenter.dy - sh);
    shieldPath.lineTo(shieldCenter.dx + sw, shieldCenter.dy - sh);
    shieldPath.quadraticBezierTo(
      shieldCenter.dx + sw,
      shieldCenter.dy + sh * 0.25,
      shieldCenter.dx,
      shieldCenter.dy + sh,
    );
    shieldPath.quadraticBezierTo(
      shieldCenter.dx - sw,
      shieldCenter.dy + sh * 0.25,
      shieldCenter.dx - sw,
      shieldCenter.dy - sh,
    );
    shieldPath.close();

    // Shield fill and outline
    canvas.drawPath(
      shieldPath,
      Paint()..color = Colors.white.withValues(alpha: 0.16)..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      shieldPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );

    // Bold Checkmark inside shield
    final checkPath = Path();
    checkPath.moveTo(shieldCenter.dx - sw * 0.38, shieldCenter.dy - sh * 0.05);
    checkPath.lineTo(shieldCenter.dx - sw * 0.05, shieldCenter.dy + sh * 0.28);
    checkPath.lineTo(shieldCenter.dx + sw * 0.42, shieldCenter.dy - sh * 0.32);
    canvas.drawPath(
      checkPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  // 2. Fake Online Store: Stylized storefront with striped awning and shopping bag with alert
  void _paintFakeOnlineStore(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // --- Left / Center: Stylized Storefront Building ---
    final storeW = math.min(w * 0.42, 130.0);
    final storeH = h * 0.72;
    final storeCenter = Offset(w * 0.36, h * 0.52);

    // Store frame background
    final frameRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: storeCenter, width: storeW, height: storeH),
      const Radius.circular(8.0),
    );
    canvas.drawRRect(
      frameRect,
      Paint()..color = const Color(0xFF431407)..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      frameRect,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );

    // Store Awning / Canopy on top
    final awningH = storeH * 0.32;
    final awningTop = storeCenter.dy - storeH * 0.5;
    const numScallops = 5;
    final scallopW = storeW / numScallops;

    for (int i = 0; i < numScallops; i++) {
      final left = (storeCenter.dx - storeW * 0.5) + i * scallopW;
      final isStripe = i % 2 == 0;
      final stripeColor = isStripe ? const Color(0xFFF59E0B) : const Color(0xFFB45309);

      final stripePath = Path();
      stripePath.moveTo(left, awningTop);
      stripePath.lineTo(left + scallopW, awningTop);
      stripePath.lineTo(left + scallopW, awningTop + awningH * 0.75);
      stripePath.quadraticBezierTo(
        left + scallopW * 0.5,
        awningTop + awningH,
        left,
        awningTop + awningH * 0.75,
      );
      stripePath.close();

      canvas.drawPath(stripePath, Paint()..color = stripeColor..style = PaintingStyle.fill);
    }

    // Showcase Window with slashed price tag inside
    final winW = storeW * 0.78;
    final winH = storeH * 0.44;
    final winCenter = Offset(storeCenter.dx, storeCenter.dy + storeH * 0.16);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: winCenter, width: winW, height: winH),
        const Radius.circular(5.0),
      ),
      Paint()..color = const Color(0xFF270D03),
    );

    // Slashed Price Tag shape (trapezoid with angled corners)
    final tagW = winW * 0.65;
    final tagH = winH * 0.45;
    final tagCenter = winCenter;
    final tagRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: tagCenter, width: tagW, height: tagH),
      const Radius.circular(4.0),
    );
    canvas.drawRRect(
      tagRect,
      Paint()..color = const Color(0xFFDC2626).withValues(alpha: 0.35),
    );
    canvas.drawRRect(
      tagRect,
      Paint()
        ..color = const Color(0xFFF87171)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Price tag slash line (symbolizing fake slashed discount)
    canvas.drawLine(
      Offset(tagCenter.dx - tagW * 0.35, tagCenter.dy + tagH * 0.35),
      Offset(tagCenter.dx + tagW * 0.35, tagCenter.dy - tagH * 0.35),
      Paint()
        ..color = const Color(0xFFF87171)
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );

    // --- Right: Shopping Bag with Warning Triangle ---
    final bagCenter = Offset(w * 0.73, h * 0.50);
    final bagW = math.min(h * 0.48, 52.0);
    final bagH = bagW * 1.05;

    // Glowing halo
    canvas.drawCircle(
      bagCenter,
      bagW * 0.75,
      Paint()..color = Colors.white.withValues(alpha: 0.10),
    );

    // Bag body
    final bagPath = Path();
    bagPath.moveTo(bagCenter.dx - bagW * 0.40, bagCenter.dy - bagH * 0.32);
    bagPath.lineTo(bagCenter.dx + bagW * 0.40, bagCenter.dy - bagH * 0.32);
    bagPath.lineTo(bagCenter.dx + bagW * 0.48, bagCenter.dy + bagH * 0.45);
    bagPath.lineTo(bagCenter.dx - bagW * 0.48, bagCenter.dy + bagH * 0.45);
    bagPath.close();

    canvas.drawPath(
      bagPath,
      Paint()..color = Colors.white.withValues(alpha: 0.20)..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      bagPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // Bag handles (semi-circle on top)
    final handleRect = Rect.fromCenter(
      center: Offset(bagCenter.dx, bagCenter.dy - bagH * 0.32),
      width: bagW * 0.45,
      height: bagH * 0.45,
    );
    canvas.drawArc(
      handleRect,
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );

    // Warning Triangle Emblem centered on bag
    _drawWarningTriangle(canvas, Offset(bagCenter.dx, bagCenter.dy + bagH * 0.08), size: bagW * 0.42);
  }

  // 3. Bank Impersonation: Classical bank architecture and incoming call with warning waves
  void _paintBankImpersonation(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // --- Left / Center: Classical Bank Architecture ---
    final bankW = math.min(w * 0.38, 115.0);
    final bankH = h * 0.72;
    final bankCenter = Offset(w * 0.35, h * 0.52);

    // Pediment (triangular roof)
    final pedimentTop = bankCenter.dy - bankH * 0.50;
    final pedimentBottom = bankCenter.dy - bankH * 0.20;
    final pedimentPath = Path();
    pedimentPath.moveTo(bankCenter.dx, pedimentTop);
    pedimentPath.lineTo(bankCenter.dx + bankW * 0.48, pedimentBottom);
    pedimentPath.lineTo(bankCenter.dx - bankW * 0.48, pedimentBottom);
    pedimentPath.close();

    canvas.drawPath(
      pedimentPath,
      Paint()..color = Colors.white.withValues(alpha: 0.25)..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      pedimentPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );

    // Decorative coin / seal in pediment center
    canvas.drawCircle(
      Offset(bankCenter.dx, pedimentBottom - (pedimentBottom - pedimentTop) * 0.38),
      3.8,
      Paint()..color = const Color(0xFFFBBF24),
    );

    // Lintel beam below pediment
    final lintelRect = Rect.fromCenter(
      center: Offset(bankCenter.dx, pedimentBottom + 2.5),
      width: bankW * 0.94,
      height: 4.5,
    );
    canvas.drawRect(lintelRect, Paint()..color = Colors.white);

    // 3 Classical Pillars / Columns
    final colTop = pedimentBottom + 5.0;
    final colBottom = bankCenter.dy + bankH * 0.34;
    final colH = colBottom - colTop;
    final colW = bankW * 0.12;
    final colSpacing = bankW * 0.30;

    for (int i = -1; i <= 1; i++) {
      final colX = bankCenter.dx + i * colSpacing;
      final colRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(colX, colTop + colH / 2), width: colW, height: colH),
        const Radius.circular(2.0),
      );
      canvas.drawRRect(
        colRect,
        Paint()..color = Colors.white.withValues(alpha: 0.45)..style = PaintingStyle.fill,
      );
      canvas.drawRRect(
        colRect,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
    }

    // Base Steps (2 tiers)
    final step1 = Rect.fromCenter(
      center: Offset(bankCenter.dx, colBottom + 3.0),
      width: bankW * 0.94,
      height: 5.0,
    );
    final step2 = Rect.fromCenter(
      center: Offset(bankCenter.dx, colBottom + 8.5),
      width: bankW * 1.02,
      height: 5.5,
    );
    canvas.drawRect(step1, Paint()..color = Colors.white.withValues(alpha: 0.7));
    canvas.drawRect(step2, Paint()..color = Colors.white);

    // --- Right: Incoming Fraudulent Call & Alert Waves ---
    final callCenter = Offset(w * 0.72, h * 0.50);
    final callD = math.min(h * 0.54, 56.0);

    // Call circle (red warning circle)
    canvas.drawCircle(
      callCenter,
      callD / 2,
      Paint()..color = const Color(0xFFDC2626).withValues(alpha: 0.35),
    );
    canvas.drawCircle(
      callCenter,
      callD / 2,
      Paint()
        ..color = const Color(0xFFEF4444)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // Radio broadcast sound waves
    for (int r = 1; r <= 2; r++) {
      final waveRadius = (callD / 2) + r * 9.0;
      canvas.drawArc(
        Rect.fromCircle(center: callCenter, radius: waveRadius),
        -math.pi * 0.35,
        math.pi * 0.70,
        false,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.45 - r * 0.15)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6 - r * 0.3
          ..strokeCap = StrokeCap.round,
      );
    }

    // Phone Handset Receiver silhouette
    _drawPhoneHandset(canvas, callCenter, size: callD * 0.44, color: Colors.white);

    // Floating Caution Shield / Badge at top right of call
    final badgeCenter = Offset(callCenter.dx + callD * 0.36, callCenter.dy - callD * 0.36);
    _drawAlertBadge(canvas, badgeCenter, radius: 9.0);
  }

  // 4. Fake Investment: Analytics board with soaring curve and hazard emblem
  void _paintFakeInvestment(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // --- Left / Center: Analytics Chart Board ---
    final boardW = math.min(w * 0.42, 132.0);
    final boardH = h * 0.72;
    final boardCenter = Offset(w * 0.36, h * 0.52);

    // Chart card background
    final boardRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: boardCenter, width: boardW, height: boardH),
      const Radius.circular(8.0),
    );
    canvas.drawRRect(
      boardRect,
      Paint()..color = const Color(0xFF0F172A)..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      boardRect,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.30)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // Horizontal grid lines (2 lines)
    for (int i = -1; i <= 1; i += 2) {
      final y = boardCenter.dy + i * (boardH * 0.22);
      canvas.drawLine(
        Offset(boardCenter.dx - boardW * 0.40, y),
        Offset(boardCenter.dx + boardW * 0.40, y),
        Paint()..color = Colors.white.withValues(alpha: 0.10)..strokeWidth = 1.0,
      );
    }

    // Hyperbolic Soaring Profit Curve Path
    final startPt = Offset(boardCenter.dx - boardW * 0.38, boardCenter.dy + boardH * 0.28);
    final midPt1 = Offset(boardCenter.dx - boardW * 0.15, boardCenter.dy + boardH * 0.22);
    final midPt2 = Offset(boardCenter.dx + boardW * 0.10, boardCenter.dy + boardH * 0.10);
    final peakPt = Offset(boardCenter.dx + boardW * 0.34, boardCenter.dy - boardH * 0.30);

    final curvePath = Path();
    curvePath.moveTo(startPt.dx, startPt.dy);
    curvePath.cubicTo(
      midPt1.dx,
      midPt1.dy,
      midPt2.dx,
      midPt2.dy,
      peakPt.dx,
      peakPt.dy,
    );

    // Filled area under the curve
    final fillPath = Path.from(curvePath);
    fillPath.lineTo(peakPt.dx, boardCenter.dy + boardH * 0.38);
    fillPath.lineTo(startPt.dx, boardCenter.dy + boardH * 0.38);
    fillPath.close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF34D399).withValues(alpha: 0.4),
            const Color(0xFF34D399).withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCenter(center: boardCenter, width: boardW, height: boardH)),
    );

    // Stroke for the curve
    canvas.drawPath(
      curvePath,
      Paint()
        ..color = const Color(0xFF34D399)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round,
    );

    // Glowing apex marker at the peak of the curve
    canvas.drawCircle(
      peakPt,
      5.0,
      Paint()..color = const Color(0xFF34D399).withValues(alpha: 0.4),
    );
    canvas.drawCircle(
      peakPt,
      3.0,
      Paint()..color = Colors.white,
    );

    // --- Right: High Yield Rocket / Upward Arrow & Caution Emblem ---
    final arrowCenter = Offset(w * 0.73, h * 0.50);
    final arrowD = math.min(h * 0.54, 56.0);

    // Outer circle
    canvas.drawCircle(
      arrowCenter,
      arrowD / 2,
      Paint()..color = Colors.white.withValues(alpha: 0.14),
    );
    canvas.drawCircle(
      arrowCenter,
      arrowD / 2,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    // Bold diagonal arrow pointing northeast
    final arrowPath = Path();
    final arrowLen = arrowD * 0.52;
    final p0 = Offset(arrowCenter.dx - arrowLen * 0.40, arrowCenter.dy + arrowLen * 0.40);
    final p1 = Offset(arrowCenter.dx + arrowLen * 0.35, arrowCenter.dy - arrowLen * 0.35);

    // Arrow shaft
    arrowPath.moveTo(p0.dx, p0.dy);
    arrowPath.lineTo(p1.dx, p1.dy);

    // Arrow head
    final headLen = arrowLen * 0.32;
    arrowPath.moveTo(p1.dx - headLen, p1.dy);
    arrowPath.lineTo(p1.dx, p1.dy);
    arrowPath.lineTo(p1.dx, p1.dy + headLen);

    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = const Color(0xFFFBBF24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Floating hazard emblem
    _drawAlertBadge(
      canvas,
      Offset(arrowCenter.dx + arrowD * 0.36, arrowCenter.dy - arrowD * 0.36),
      radius: 9.0,
    );
  }

  void _drawExclamationMark(Canvas canvas, Offset center, {required double size, required Color color}) {
    final barH = size * 0.55;
    final dotR = size * 0.12;
    final paint = Paint()..color = color..style = PaintingStyle.fill;

    // Bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx, center.dy - size * 0.15), width: size * 0.22, height: barH),
        Radius.circular(size * 0.1),
      ),
      paint,
    );
    // Dot
    canvas.drawCircle(
      Offset(center.dx, center.dy + size * 0.32),
      dotR,
      paint,
    );
  }

  void _drawWarningTriangle(Canvas canvas, Offset center, {required double size}) {
    final half = size / 2;
    final path = Path();
    path.moveTo(center.dx, center.dy - half);
    path.lineTo(center.dx + half * 1.1, center.dy + half * 0.85);
    path.lineTo(center.dx - half * 1.1, center.dy + half * 0.85);
    path.close();

    canvas.drawPath(
      path,
      Paint()..color = const Color(0xFFF59E0B)..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    _drawExclamationMark(
      canvas,
      Offset(center.dx, center.dy + size * 0.10),
      size: size * 0.55,
      color: const Color(0xFF78350F),
    );
  }

  void _drawPhoneHandset(Canvas canvas, Offset center, {required double size, required Color color}) {
    final path = Path();
    final s = size / 2;
    path.moveTo(center.dx - s * 0.5, center.dy + s * 0.5);
    path.quadraticBezierTo(center.dx - s * 0.6, center.dy - s * 0.2, center.dx + s * 0.1, center.dy - s * 0.5);
    path.lineTo(center.dx + s * 0.4, center.dy - s * 0.3);
    path.lineTo(center.dx + s * 0.2, center.dy - s * 0.05);
    path.quadraticBezierTo(center.dx, center.dy + s * 0.1, center.dx - s * 0.15, center.dy + s * 0.2);
    path.lineTo(center.dx - s * 0.3, center.dy + s * 0.4);
    path.close();

    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
  }

  void _drawAlertBadge(Canvas canvas, Offset center, {required double radius}) {
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = const Color(0xFFDC2626),
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    _drawExclamationMark(canvas, center, size: radius * 1.1, color: Colors.white);
  }

  void _paintDefaultScene(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(
      center,
      size.height * 0.28,
      Paint()..color = Colors.white.withValues(alpha: 0.2),
    );
  }
}
