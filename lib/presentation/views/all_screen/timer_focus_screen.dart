import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:joedaniels85_timer_app/presentation/widgets/custom_bottom_nav.dart';

import '../../../core/constants/app_colors.dart';
import '../../../routes/app_route.dart';

class TimerFocusScreen extends StatelessWidget {
  const TimerFocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Focus Timer",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "Choose your screen-free duration",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "30 min",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AssetPath.cicle2),
                    Column(
                      spacing: 10,
                      children: [
                        Image.asset(
                          AssetPath.timer,
                          width: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "30:00",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                        ),
                        Text(
                          "Ready to start",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 100),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(AppRoutes.pauseActiveScreen);
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white),
                      Text("Start Session"),
                    ],
                  ),
                ),
                SizedBox(height: 15),
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

                    },
                    icon: Image.asset(AssetPath.moonIcon, width: 25),
                    label: const Text("Until bedtime (8h)"),
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
