import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/asset_path.dart';
import '../../../data/models/screenmodel/progress_pesponse_model.dart';
import '../../viewmodels/controller/achievement_controller.dart';
import '../../viewmodels/controller/progress_controller.dart';
import '../../widgets/achievement_card .dart';
import '../../widgets/start_card.dart';
import '../../widgets/status_card.dart';
import '../../widgets/weekly_minutes_bar_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({super.key});

  final AchievementController achievementController = Get.put(
    AchievementController(),
  );
  final UserProgressController progressController = Get.put(
    UserProgressController(),
  );

  void _initialFetch() {
    progressController.fetchUserProgress();
    achievementController.fetchActivities();
  }

  @override
  Widget build(BuildContext context) {
    _initialFetch();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await progressController.fetchUserProgress();
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
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 10.h),

                /// Total + Today Row
                _buildRow(),

                SizedBox(height: 10.h),
                Text(
                  "Weekly Progress",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),

                Obx(() {
                  final entries = progressController.todayActivities;
                  if (entries.isEmpty)
                    return Text(
                      "No activities yet",
                      style: TextStyle(fontSize: 14.sp),
                    );
                  return buildWeeklyMinutesChart(context, entries);
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
                  if (achievementController.nextAchievements.isEmpty &&
                      achievementController.unlockedAchievements.isEmpty) {
                    return Center(
                      child: Text(
                        "No achievements found.",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  } else {
                    final allAchievements = [
                      ...achievementController.unlockedAchievements,
                      ...achievementController.nextAchievements,
                    ];

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 1.05,
                      ),
                      itemCount: allAchievements.length,
                      itemBuilder: (context, index) {
                        final achievement = allAchievements[index];
                        return AchievementCard(
                          title: achievement.title ?? "",
                          bgColor: AppColors.targetColor,
                          imageIcon: AssetPath.targetIcon,
                          isActive: achievement.completed ?? false,
                        );
                      },
                    );
                  }
                }),

                SizedBox(height: 20.h),

                /// Status Card
                Obx(() {
                  final entries = progressController.todayActivities;
                  if (entries.isEmpty)
                    return Text(
                      "No activities yet",
                      style: TextStyle(fontSize: 14.sp),
                    );
                  return _weeklyStatusCard(context, entries);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Total Time + Today %
  Widget _buildRow() {
    return Obx(() {
      // API থেকে আসা total duration ধরে নিই seconds, তাই divide by 60
      final backendMinutes = ((progressController.progressResponse.value?.data?.overall?.totalDurationMinutes ?? 0) / 60).round();

      // আজকের activities duration add
      final todayMinutes = progressController.todayActivities.fold<int>(
        0,
            (sum, entry) => sum + ((entry.duration ?? 0) / 60).round(),
      );

      final totalMinutes = backendMinutes + todayMinutes;
      final totalToday = progressController.todayActivities.length;
      final completedToday = progressController.todayActivities
          .where((entry) => entry.status?.toLowerCase() == "success")
          .length;
      final todayPercent = totalToday > 0
          ? ((completedToday / totalToday) * 100).toStringAsFixed(0)
          : "0";

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: StartCard(
              vPadding: 0.h,
              showButton: false,
              centerIcon: AssetPath.analysis,
              size: 60.w,
              titleSpans: [
                TextSpan(
                  text: "${totalMinutes}m",
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "\nTotal Time",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
              onButtonTap: () {},
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: StartCard(
              vPadding: 0.h,
              showButton: false,
              centerIcon: AssetPath.node,
              size: 60.w,
              titleSpans: [
                TextSpan(
                  text: "$todayPercent%",
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "\nToday",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
              onButtonTap: () {},
            ),
          ),
        ],
      );
    });
  }

  Widget buildWeeklyMinutesChart(
      BuildContext context,
      List<ActivityEntry> entries,
      ) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    final last7Days = List.generate(
      7,
          (i) => startOfWeek.add(Duration(days: i)),
    );

    final dailyMinutes = last7Days.map((day) {
      final dailyEntries = entries.where((entry) {
        final date = entry.startedAt ?? DateTime.now();
        return date.year == day.year &&
            date.month == day.month &&
            date.day == day.day;
      });
      final totalMinutes = dailyEntries.fold<double>(
        0,
            (sum, e) => sum + ((e.duration ?? 0) / 60),
      );
      return totalMinutes.toInt();
    }).toList();

    return WeeklyMinutesBarChart(
      minutes: dailyMinutes,
      barColor: Colors.teal,
      backgroundColor: Colors.grey.shade300,
      barWidth: 15.w,
    );
  }

  /// Status Card
  Widget _weeklyStatusCard(BuildContext context, List<ActivityEntry> entries) {
    int totalMinutes = entries.fold(
      0,
          (sum, entry) => sum + ((entry.duration ?? 0) / 60).round(),
    );
    bool allSuccess = entries.every(
          (entry) => entry.status?.toLowerCase() == "success",
    );
    String status = allSuccess ? "Success" : "Pending";
    Color statusColor = allSuccess ? Colors.green : Colors.orange;
    String dayName = "";
    if (entries.isNotEmpty) {
      DateTime date = entries.first.startedAt ?? DateTime.now();
      List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      dayName = weekDays[date.weekday % 7];
    }
    return StatusCard(
      dayName: dayName,
      minutes: "$totalMinutes min",
      status: status,
      statusColor: statusColor,
    );
  }
}
