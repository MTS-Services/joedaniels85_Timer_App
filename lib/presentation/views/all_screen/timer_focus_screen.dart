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

  final RxList<int> durations = <int>[].obs; // Custom durations added by user
  final RxInt selectedDuration = 0.obs; // 🔹 Currently selected duration (in minutes)

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

              /// 🕒 Duration Selector (Dynamic)
              SizedBox(
                height: 50.h,
                child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: durations.length + 1,
                  itemBuilder: (context, index) {
                    if (index == durations.length) {
                      // ➕ Add Custom Duration Button
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
                                      final minutes = int.tryParse(controller.text);
                                      if (minutes != null && minutes > 0) {
                                        Navigator.pop(context, minutes);
                                      }
                                    },
                                    child: const Text("Add"),
                                  ),
                                ],
                              ),
                            );

                            if (result != null && !durations.contains(result)) {
                              durations.add(result);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black, width: 1.5),
                            ),
                            child: const Center(
                              child: Icon(Icons.add, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }

                    // 🔸 Normal Duration Button
                    final minutes = durations[index];
                    final isSelected = selectedDuration.value == minutes;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectedDuration.value = minutes;
                              timerController.remainingSeconds.value = minutes * 60;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

                          // ❌ Delete Button
                          Positioned(
                            right: -5,
                            top: -5,
                            child: GestureDetector(
                              onTap: () => durations.removeAt(index),
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
                        style: theme.textTheme.bodySmall!.copyWith(color: Colors.white),
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
                    selectedDuration.value = 480;
                    timerController.remainingSeconds.value = 8 * 60 * 60;
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
