import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/asset_path.dart';
import '../../../data/services/firebase_services.dart';
import '../../viewmodels/controller/profile_controller.dart';
import '../../viewmodels/controller/profile_image_controller.dart';
import '../../viewmodels/controller/progress_controller.dart';
import '../auth_screen/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserProgressController userProgressController = Get.put(UserProgressController());
  final UserProfileController profileController = Get.put(UserProfileController());
  final ProfileImageController imageController = Get.put(ProfileImageController());
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Obx(() {
                    final file = imageController.imageFile.value;
                    final rawProfilePic = profileController.profileList.value?.profilePic;

                    // Remove extra quotes and trim
                    final profilePic = rawProfilePic?.replaceAll("'", "").trim() ?? "";

                    ImageProvider? imageProvider;

                    if (file != null) {
                      imageProvider = FileImage(file);
                    } else if (profilePic.isNotEmpty) {
                      if (profilePic.startsWith("http")) {
                        imageProvider = NetworkImage(profilePic);
                      } else {
                        final localFile = File(profilePic);
                        if (localFile.existsSync()) {
                          imageProvider = FileImage(localFile);
                        }
                      }
                    }

                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: imageController.pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 2),
                              image: DecorationImage(
                                image: imageProvider ?? AssetImage('assets/default_profile.png') as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: imageController.pickImage,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  SizedBox(height: 20.h),

                  Text(
                    "Activities",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),

                  Obx(() {
                    final name = profileController.profileList.value?.name ?? "Loading...";
                    final year = userProgressController.todayActivities.isNotEmpty
                        ? userProgressController.todayActivities.first.createdAt?.year ??
                        DateTime.now().year
                        : DateTime.now().year;

                    return Text(
                      "Member since $name $year",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14.sp),
                    );
                  }),

                  SizedBox(height: 25.h),
                  _statusProfile(),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            // -------------------- Recent Achievements --------------------
            Text(
              "Recent Achievements",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            _recentAchievements(context),

            SizedBox(height: 50.h),

            // -------------------- Log Out Button --------------------
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
                label: Text("Log Out", style: TextStyle(fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- Recent Achievements --------------------
  Widget _recentAchievements(BuildContext context) {
    return Obx(() {
      final stats = userProgressController.overallStats.value;
      final progress = userProgressController.progressResponse.value?.data;

      int totalSessions = stats?.completedActivities ?? 0;
      int streak = progress?.currentStreak ?? 0;
      int totalHours = stats?.totalActivities ?? 0;

      List<Widget> achievements = [];

      if (totalSessions >= 1) {
        achievements.add(_buildCard(context, "First Step", "Completed your first session"));
      }
      if (streak >= 3) {
        achievements.add(_buildCard(context, "3 Day Streak", "Maintained focus for 3 days"));
      }
      if (totalHours >= 1) {
        achievements.add(_buildCard(context, "Hour Master", "Completed a 1-hour session"));
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
    });
  }

  // -------------------- Achievement Card --------------------
  Widget _buildCard(BuildContext context, String text, String subText) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.r,
          child: Image.asset(AssetPath.wineIcon, width: 24.w, height: 24.h),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subText,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }

  // -------------------- Status Profile --------------------
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

  // -------------------- Status Column --------------------
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
