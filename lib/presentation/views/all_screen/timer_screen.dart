import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import '../../../routes/app_route.dart';
import '../../viewmodels/controller/progress_controller.dart';
import '../../widgets/custom_time_ticker.dart';
import '../../widgets/start_card.dart';
import '../../widgets/task_card.dart';

class TimerScreen extends StatelessWidget {
  TimerScreen({super.key});

  final UserProgressController userProgressController =
  Get.put(UserProgressController());

  Future<void> _onRefresh() async {
    await userProgressController.fetchUserProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (userProgressController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: Colors.green,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // CustomTimePicker(
                    //   onTimeSelected: (time) {
                    //     print("Selected Time: ${time.format(context)}");
                    //   },
                    // ),

                    SizedBox(height: 10.h),
                    _buildStartCard(),
                    SizedBox(height: 15.h),
                    _buildRow(),
                    SizedBox(height: 10.h),
                    Text(
                      "Quick Actions",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 10.h),
                    _buildSizedBox(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  StartCard _buildStartCard() {
    return StartCard(
      titleSpans: [
        TextSpan(text: "Ready ", style: TextStyle(fontSize: 16.sp)),
        TextSpan(text: "to \n", style: TextStyle(fontSize: 16.sp)),
        TextSpan(text: "start", style: TextStyle(fontSize: 16.sp)),
      ],
      circleImage: AssetPath.circle,
      centerIcon: AssetPath.clock,
      buttonIcon: Icons.play_arrow,
      buttonText: "Next",
      onButtonTap: () {
        Get.toNamed(AppRoutes.timerFocusScreen);
      },
    );
  }

  SizedBox _buildSizedBox() {
    return SizedBox(
      height: 500.h,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          final streak = userProgressController
              .progressResponse.value?.data?.currentStreak ??
              0;
          return Flexible(
            child: StartCard(
              vPadding: 0,
              showButton: false,
              centerIcon: AssetPath.fire,
              size: 60.w,
              titleSpans: [
                TextSpan(
                  text: "$streak",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "\nStreak",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
              onButtonTap: () {},
            ),
          );
        }),
        SizedBox(width: 10.w),
        Obx(() {
          final totalDuration = userProgressController
              .overallStats.value?.totalDurationMinutes ??
              0;
          return Flexible(
            child: StartCard(
              vPadding: 0.r,
              showButton: false,
              centerIcon: AssetPath.target,
              size: 60.w,
              titleSpans: [
                TextSpan(
                  text: "${totalDuration}m",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "\nFocus",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
              onButtonTap: () {},
            ),
          );
        }),
      ],
    );
  }
}
