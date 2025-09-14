import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../routes/app_route.dart';
class PauseActiveScreen extends StatefulWidget {
  const PauseActiveScreen({super.key});

  @override
  State<PauseActiveScreen> createState() => _PauseActiveScreenState();
}

class _PauseActiveScreenState extends State<PauseActiveScreen>
    with TickerProviderStateMixin {
  late final AnimationController _rippleCtrl;
  late final AnimationController _dashShiftCtrl;

  @override
  void initState() {
    super.initState();

    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: false);

    _dashShiftCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    Timer(const Duration(seconds: 2), () {});
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    _dashShiftCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([_rippleCtrl, _dashShiftCtrl]),
              builder: (context, _) {
                return CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: _DashedRipplesPainter(
                    progress: _rippleCtrl.value,
                    dashShift: _dashShiftCtrl.value,
                  ),
                );
              },
            ),
            Text(
              '"Your Pause is \nin progress"',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Positioned(
              bottom: 90,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(50)
                    )
                  ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.pauseFeedbackScreen);
                    },
                    child: Text("Stop"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _DashedRipplesPainter extends CustomPainter {
  final double progress;
  final double dashShift;

  _DashedRipplesPainter({required this.progress, required this.dashShift});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final baseRadius = math.min(size.width, size.height) * 0.18;
    final radii = [
      baseRadius * (1.00 + 0.10 * math.sin(progress * 2 * math.pi)),
      baseRadius *
          1.55 *
          (1.00 + 0.08 * math.sin((progress + .33) * 2 * math.pi)),
      baseRadius *
          2.10 *
          (1.00 + 0.06 * math.sin((progress + .66) * 2 * math.pi)),
    ];
    for (int i = 0; i < radii.length; i++) {
      final opacity = (0.65 - i * 0.12).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      _drawDashedCircle(
        canvas: canvas,
        center: center,
        radius: radii[i],
        paint: paint,
        dashCount: 120,
        dashPortion: 0.45,
        rotation: dashShift * 2 * math.pi * (i.isEven ? 1 : -1),
      );
    }
  }
  void _drawDashedCircle({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required Paint paint,
    required int dashCount,
    required double dashPortion,
    double rotation = 0,
  }) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final step = 2 * math.pi / dashCount;
    final sweep = step * dashPortion;
    double start = rotation;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(rect, start, sweep, false, paint);
      start += step;
    }
  }
  @override
  bool shouldRepaint(covariant _DashedRipplesPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.dashShift != dashShift;
  }
}
