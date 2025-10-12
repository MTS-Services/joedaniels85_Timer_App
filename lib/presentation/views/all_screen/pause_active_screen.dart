import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../routes/app_route.dart';
import '../../viewmodels/controller/activites_controller.dart';
import '../../viewmodels/controller/timer_controller.dart';
import '../../viewmodels/controller/duration_controller.dart';
import '../../../data/models/screenmodel/duration_model.dart';

class PauseActiveScreen extends StatefulWidget {
  const PauseActiveScreen({super.key});

  @override
  State<PauseActiveScreen> createState() => _PauseActiveScreenState();
}

class _PauseActiveScreenState extends State<PauseActiveScreen>
    with TickerProviderStateMixin {
  late final AnimationController _rippleCtrl;
  late final AnimationController _dashShiftCtrl;

  final TimerController timerController = Get.put(TimerController());
  final DurationController durationController = Get.put(DurationController());
  final ActivitiesController activitiesController = Get.put(ActivitiesController());

  @override
  void initState() {
    super.initState();
    activitiesController.fetchActivities();

    final rippleDuration = timerController.remainingSeconds.value > 0
        ? timerController.remainingSeconds.value
        : 1;

    _rippleCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: rippleDuration),
    )..forward();

    _dashShiftCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    ever(timerController.remainingSeconds, (time) {
      if (time == 0) {
        _rippleCtrl.stop();
        _dashShiftCtrl.stop();
      }
    });
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    _dashShiftCtrl.dispose();
    super.dispose();
  }

  String getRemainingMinutes() {
    // প্রতি মিনিট increment দেখানোর জন্য
    final minutes = (timerController.remainingSeconds.value / 60).ceil();
    return minutes.toString();
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
            Obx(
                  () => Text(
                "Your Pause\n${getRemainingMinutes()} min left",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 90.h,
              child: SizedBox(
                width: 150.w,
                height: 50.h,
                child: Obx(
                      () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    onPressed: durationController.isLoading.value
                        ? null
                        : () async {
                      timerController.stopTimer();
                      if (activitiesController.activitiesList.isEmpty ||
                          activitiesController.activitiesList[0].id.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "No valid activity found!",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      final activityId =
                          activitiesController.activitiesList[0].id;

                      final durationModel = DurationModel(
                        activityId: activityId,
                        duration: timerController.getElapsedSeconds(),
                      );

                      bool success =
                      await durationController.sendDuration(durationModel);

                      if (success) {
                        Get.snackbar(
                          "Success",
                          "Duration saved successfully!",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Get.toNamed(AppRoutes.pauseFeedbackScreen);
                      } else {
                        Get.snackbar(
                          "Error",
                          "Failed to save duration. Try again.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: durationController.isLoading.value
                        ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.w,
                      ),
                    )
                        : Text(
                      "Stop",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
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
      baseRadius * 1.55 * (1.00 + 0.08 * math.sin((progress + .33) * 2 * math.pi)),
      baseRadius * 2.10 * (1.00 + 0.06 * math.sin((progress + .66) * 2 * math.pi)),
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
    return oldDelegate.progress != progress || oldDelegate.dashShift != dashShift;
  }
}
