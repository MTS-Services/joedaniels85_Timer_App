import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import '../../../routes/app_route.dart';
import '../../widgets/start_card.dart';
import '../../widgets/task_card.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StartCard(
                  titleSpans: [
                    const TextSpan(
                      text: "Ready ",
                      style: TextStyle(fontSize: 16),
                    ),
                    const TextSpan(
                      text: "to \n",
                      style: TextStyle(fontSize: 16),
                    ),
                    const TextSpan(
                      text: "start",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                  circleImage: AssetPath.circle,
                  centerIcon: AssetPath.clock,
                  buttonIcon: Icons.play_arrow,
                  buttonText: "Next",
                  onButtonTap: () {
                    Get.toNamed(AppRoutes.timerFocusScreen);
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StartCard(
                      vPadding: 0,
                      hPadding: 60.0,
                      showButton: false,
                      centerIcon: AssetPath.fire,
                      size: 60,
                      titleSpans: [
                        const TextSpan(
                          text: "38",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: "\nStreak",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                      onButtonTap: () {

                      },
                    ),
                    StartCard(
                      vPadding: 0,
                      hPadding: 60.0,
                      showButton: false,
                      centerIcon: AssetPath.target,
                      size: 60,
                      titleSpans: [
                        const TextSpan(
                          text: "45m",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: "\nStreak",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                      onButtonTap: () {
                        print("Next tapped");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Quick Actions"),
                SizedBox(height: 10),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: "View Progress",
                        subTitle: "Check your weekly stats",
                        imagePath: AssetPath.chartIcon,
                        actions: [
                          ActionIcon(
                            icon: Icons.arrow_forward_ios_outlined,
                            color: Colors.green,
                            onTap: () {
                              print("Checked!");
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
