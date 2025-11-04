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

  // Initialize with some default durations and make it persistent
  final RxList<int> defaultDurations = <int>[5, 10, 15, 20, 25, 30].obs;
  final RxList<int> customDurations = <int>[].obs;

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
                height: 50.h,
                child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: defaultDurations.length + customDurations.length + 1,
                  itemBuilder: (context, index) {
                    // Custom duration button (last item)
                    if (index == defaultDurations.length + customDurations.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () async {
                            final controller = TextEditingController();
                            final result = await showDialog<int>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Add Custom Duration"),
                                content: TextField(
                                  controller: controller,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Enter minutes",
                                    hintText: "e.g. 25",
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final minutes =
                                      int.tryParse(controller.text);
                                      if (minutes != null && minutes > 0) {
                                        Navigator.pop(context, minutes);
                                      }
                                    },
                                    child: const Text("Add"),
                                  ),
                                ],
                              ),
                            );

                            if (result != null &&
                                !defaultDurations.contains(result) &&
                                !customDurations.contains(result)) {
                              customDurations.add(result);
                            }
                          },
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10 , vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border:
                              Border.all(color: Colors.black, width: 1.5),
                            ),
                            child: const Center(
                              child: Row(
                                children: [
                                  Text("custom " , style: TextStyle(fontSize: 16),),
                                  Icon(Icons.add, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // Get the actual duration value
                    final int minutes;
                    final bool isCustomDuration;

                    if (index < defaultDurations.length) {
                      minutes = defaultDurations[index];
                      isCustomDuration = false;
                    } else {
                      minutes = customDurations[index - defaultDurations.length];
                      isCustomDuration = true;
                    }

                    final isSelected =
                        timerController.remainingSeconds.value ==
                            minutes * 60;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () => timerController.resetTimer(minutes),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.black, width: 1.5),
                              ),
                              child: Center(
                                child: Text(
                                  "$minutes min",
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Delete button - only shown for custom durations
                          if (isCustomDuration)
                            Positioned(
                              right: -5,
                              top: -5,
                              child: GestureDetector(
                                onTap: () {
                                  final customIndex = index - defaultDurations.length;
                                  customDurations.removeAt(customIndex);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                )),
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

              /// ▶️ Start Session Button
              Obx(() {
                final isButtonEnabled = timerController.remainingSeconds.value > 0;

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isButtonEnabled
                        ? () {
                      final activityId = activitiesController.activitiesList.isNotEmpty
                          ? activitiesController.activitiesList[0].id
                          : "default_activity";

                      timerController.startTimer(
                        currentActivityId: activityId,
                        durationInSec: timerController.remainingSeconds.value,
                      );
                      Get.toNamed(AppRoutes.pauseActiveScreen);
                    }
                        : null,
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: const Text("Start Session"),
                  ),
                );
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}