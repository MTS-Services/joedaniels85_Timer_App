import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:joedaniels85_timer_app/routes/app_route.dart';

class TealLoaderScreen extends StatefulWidget {
  const TealLoaderScreen({super.key});

  @override
  State<TealLoaderScreen> createState() => _TealLoaderScreenState();
}

class _TealLoaderScreenState extends State<TealLoaderScreen>
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

    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.bottomNavBarScreen);
    });
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    _dashShiftCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = AppColors.primary;
    return Scaffold(
      backgroundColor: bg,
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
            Image.asset(
              AssetPath.playIcon,
              width: 140.w,
              color: Colors.white,
            ),
            Positioned(
              bottom: 90.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              child: _HomeIndicator(),
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

  _DashedRipplesPainter({
    required this.progress,
    required this.dashShift,
  });

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
        ..strokeWidth = 2.w;

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

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
