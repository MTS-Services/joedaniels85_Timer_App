import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/asset_path.dart';
import '../../../data/services/firebase_services.dart';
import '../../viewmodels/controller/profile_controller.dart';
import '../../viewmodels/controller/progress_controller.dart';
import '../auth_screen/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserProgressController userProgressController = Get.put(UserProgressController());
  final UserProfileController profile = Get.put(UserProfileController());
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final year = userProgressController.todayActivities.isNotEmpty
        ? userProgressController.todayActivities.first.createdAt?.year ??
        DateTime.now().year
        : DateTime.now().year;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    child: Icon(Icons.person, size: 50.sp),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Activities",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    final name = profile.profileList.isNotEmpty
                        ? profile.profileList.first.name
                        : "Loading...";
                    return Text(
                      "Member since $name $year",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                      ),
                    );
                  }),
                  SizedBox(height: 25.h),
                  _statusProfile(),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Recent Achievements",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              final stats = userProgressController.overallStats.value;
              final progress = userProgressController.progressResponse.value?.data;

              int totalSessions = stats?.completedActivities ?? 0;
              int streak = progress?.currentStreak ?? 0;
              int totalHours = stats?.totalActivities ?? 0;

              List<Widget> achievements = [];

              if (totalSessions >= 1) {
                achievements.add(
                  _buildCard(context, "First Step", "Completed your first session"),
                );
              }

              if (streak >= 3) {
                achievements.add(
                  _buildCard(context, "3 Day Streak", "Maintained focus for 3 days"),
                );
              }

              if (totalHours >= 1) {
                achievements.add(
                  _buildCard(context, "Hour Master", "Completed a 1-hour session"),
                );
              }

              if (achievements.isEmpty) {
                achievements.add(
                  Text(
                    "No achievements yet. Keep going!",
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                );
              }

              return Column(children: achievements);
            }),
            SizedBox(height: 50.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                onPressed: () async {
                  await firebaseServices.signOut();
                  Get.offAll(() => SignInScreen());
                },
                icon: Icon(Icons.login, size: 24.sp),
                label: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String text, String subText) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.r,
          child: Image.asset(
            AssetPath.wineIcon,
            width: 24.w,
            height: 24.h,
          ),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subText, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp)),
      ),
    );
  }

  Widget _statusProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _statusColumn(
                value: userProgressController.overallStats.value?.completedActivities ?? 0,
                label: "Total Sessions",
              ),
            ),
            Flexible(
              child: _statusColumn(
                value: userProgressController.overallStats.value?.totalActivities ?? 0,
                label: "Screen \nfree time",
                suffix: "h",
              ),
            ),
            Flexible(
              child: _statusColumn(
                value: userProgressController.progressResponse.value?.data?.currentStreak ?? 0,
                label: "Current Streak",
              ),
            ),
            Flexible(
              child: _statusColumn(
                value: userProgressController.categoryBreakdownList.isNotEmpty
                    ? userProgressController.categoryBreakdownList.first.count ?? 0
                    : 0,
                label: "Longest Streak",
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _statusColumn({
    required int value,
    required String label,
    String suffix = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$value$suffix",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
