import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/asset_path.dart';
import '../../viewmodels/controller/achievement_controller.dart';
import '../../viewmodels/controller/progress_controller.dart';
import '../../widgets/achievement_card .dart';
import '../../widgets/start_card.dart';
import '../../widgets/status_card.dart';
import '../../widgets/weekly_minutes_bar_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({super.key});

  final AchievementController achievementController =
  Get.put(AchievementController());

  final UserProgressController progressController =
  Get.put(UserProgressController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      progressController.fetchProgress();
      achievementController.fetchActivities();
    });

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await progressController.fetchProgress();
            await achievementController.fetchActivities();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "Last 7 days",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 10.h),

                _buildRow(),

                SizedBox(height: 15.h),

                Text(
                  "Weekly Progress",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.h),

                /// ✔ FIXED WEEKLY PROGRESS CHART
                Obx(() {
                  final dp = progressController.dailyProgress.value;

                  if (dp == null) {
                    return const Text("No daily progress yet");
                  }

                  // All days of the week
                  final allDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];


                  final minutesList = List<int>.filled(7, 0);

                  final dayIndex = allDays.indexWhere((d) =>
                  d.toLowerCase() == dp.dayName.substring(0, 3).toLowerCase());

                  if (dayIndex != -1) {
                    minutesList[dayIndex] = dp.stats.total ?? 0;
                  }

                  return DayWiseMinutesBarChart(
                    minutes: minutesList,
                    barColor: Colors.teal,
                    backgroundColor: Colors.grey.shade300,
                    barWidth: 15.w,
                    days: allDays,
                  );
                }),



                SizedBox(height: 15.h),

                Text(
                  "Achievements",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.h),

                /// Achievements Grid
                Obx(() {
                  final all = [
                    ...achievementController.unlockedAchievements,
                    ...achievementController.nextAchievements,
                  ];

                  if (all.isEmpty) {
                    return Center(child: Text("No achievements found."));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: all.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 1.05,
                    ),
                    itemBuilder: (_, i) {
                      final item = all[i];
                      return AchievementCard(
                        title: item.title ?? "",
                        bgColor: AppColors.targetColor,
                        imageIcon: AssetPath.targetIcon,
                        isActive: item.completed ?? false,
                      );
                    },
                  );
                }),

                SizedBox(height: 20.h),

                /// ✔ FIXED STATUS CARD (safe)
                Obx(() {
                  final dp = progressController.dailyProgress.value;

                  if (dp == null || dp.activities.isEmpty) {
                    return Text("No activities yet");
                  }

                  return StatusCard(
                    dayName: dp.dayName ?? "",
                    minutes: "${dp.stats.total ?? 0} min",
                    status: dp.activities.first.status ?? "Unknown",
                    statusColor: Colors.green,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// TOTAL + TODAY CARDS
  Widget _buildRow() {
    return Obx(() {
      final dp = progressController.dailyProgress.value;

      if (dp == null) {
        return SizedBox.shrink();
      }

      final totalMinutes = dp.stats.total ?? 0;
      final todayMinutes = dp.stats.totalDuration ?? 0;

      return Row(
        children: [
          Expanded(
            child: StartCard(
              showButton: false,
              centerIcon: AssetPath.analysis,
              size: 60.w,
              titleSpans: [
                TextSpan(
                  text: "${totalMinutes}m\n",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: "Total Time",
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: StartCard(
              showButton: false,
              centerIcon: AssetPath.node,
              size: 60.w,
              titleSpans: [
                TextSpan(
                  text: "$todayMinutes\n",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: "Today",
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),
        ],
      );
    });
  }
}
