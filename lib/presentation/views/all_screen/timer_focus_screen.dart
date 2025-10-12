import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import '../../../routes/app_route.dart';
import '../../viewmodels/controller/activites_controller.dart';
import '../../viewmodels/controller/timer_controller.dart';

class TimerFocusScreen extends StatelessWidget {
  TimerFocusScreen({super.key});

  final ActivitiesController activitiesController = Get.find<ActivitiesController>();
  final TimerController timerController = Get.put(TimerController());
  final List<int> durations = [15, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Focus Timer", style: theme.textTheme.headlineMedium),
              Text("Choose your screen-free duration", style: theme.textTheme.bodySmall),
              const SizedBox(height: 30),
              SizedBox(
                height: 40.h,
                child:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: durations.length,
                  itemBuilder: (context, index) {
                    final minutes = durations[index];
                    final isSelected =
                        timerController.remainingSeconds.value == minutes * 60;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () => timerController.resetTimer(minutes),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              "$minutes min",
                              style: theme.textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
              const SizedBox(height: 80),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetPath.cicle2),
                  Column(
                    children: [
                      Image.asset(AssetPath.timer, width: 50, color: Colors.white),
                      const SizedBox(height: 10),
                      Obx(() => Text(
                        timerController.timeString,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )),
                      Obx(() => Text(
                        timerController.isRunning.value
                            ? "Focusing..."
                            : "Ready to start",
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: Colors.white),
                      )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Obx(() {
                final activityId = activitiesController.activitiesList.isNotEmpty
                    ? activitiesController.activitiesList[0].id
                    : null;

                final isButtonEnabled = activityId != null &&
                    activityId.isNotEmpty &&
                    timerController.remainingSeconds.value > 0;

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isButtonEnabled
                        ? () {
                      timerController.startTimer(
                        currentActivityId: activityId!,
                        durationInSec:
                        timerController.remainingSeconds.value,
                      );
                      Get.toNamed(AppRoutes.pauseActiveScreen);
                    }
                        : null,
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: const Text("Start Session"),
                  ),
                );
              }),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    timerController.resetTimer(8 * 60);
                  },
                  icon: Image.asset(AssetPath.moonIcon, width: 25),
                  label: const Text("Until bedtime (8h)"),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
