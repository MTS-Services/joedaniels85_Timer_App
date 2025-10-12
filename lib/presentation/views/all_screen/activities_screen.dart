import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/app_route.dart';
import '../../viewmodels/controller/activites_controller.dart';
import '../../widgets/activity_card.dart';

class ActivitiesScreen extends StatelessWidget {
  ActivitiesScreen({super.key});

  final ActivitiesController _activitiesController = Get.put(
    ActivitiesController(),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _activitiesController.fetchActivities();
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Activities",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 25.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                "Discover meaningful offline activities",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: Obx(() {
                  if (_activitiesController.isLoading.value) {
                    return Center(
                        child: SizedBox(
                            width: 30.w,
                            height: 30.w,
                            child: CircularProgressIndicator(strokeWidth: 2.w)));
                  }
                  if (_activitiesController.activitiesList.isEmpty) {
                    return Center(
                      child: Text(
                        "No activities found.",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: _activitiesController.activitiesList.length,
                    itemBuilder: (context, index) {
                      final activity = _activitiesController.activitiesList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.activityDetailsScreen,
                            arguments: {
                              'title': activity.title,
                              'description': activity.description,
                              'duration': activity.duration,
                              'category': activity.category,
                              'difficulty': activity.difficulty,
                              'benefits': activity.benefits,
                              'steps': activity.howToStart,
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: ActivityCard(
                            title: activity.title,
                            description: activity.description,
                            duration: activity.duration,
                            level: activity.difficulty,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
