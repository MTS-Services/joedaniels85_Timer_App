import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import '../../widgets/activity_avatar.dart';

class ActivityDetailsScreen extends StatelessWidget {
  const ActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String title = args['title'] ?? "No Title";
    final String duration = args['duration'] ?? "N/A";
    final String category = args['category'] ?? "N/A";
    final String difficulty = args['difficulty'] ?? "N/A";
    final List<String> benefits = List<String>.from(args['benefits'] ?? []);
    final List<String> steps = List<String>.from(args['steps'] ?? []);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCircleAvatar(title: title),
              SizedBox(height: 30.h),
              Text("Activities", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 25.sp)),
              SizedBox(height: 5.h),
              Text(
                "Discover meaningful offline activities",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 30.h),
              _statusBar(
                context,
                duration: duration,
                category: category,
                difficulty: difficulty,
              ),
              SizedBox(height: 25.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Benefits",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),
                  ...benefits.map((benefit) => _buildRow(context, benefit)),
                  SizedBox(height: 10.h),
                  Text(
                    "Steps",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),
                  ...steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    return _chooseStatus(context, "${index + 1}", step);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseStatus(BuildContext context, String a, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10.r,
            backgroundColor: AppColors.statusColor,
            child: Text(
              a,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 15.sp, color: Colors.white),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp))),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          CircleAvatar(radius: 5.r, backgroundColor: Colors.green),
          SizedBox(width: 5.w),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp))),
        ],
      ),
    );
  }

  Widget _statusBar(
      BuildContext context, {
        required String duration,
        required String category,
        required String difficulty,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statusColumn(context, "Duration", duration),
          _statusColumn(context, "Category", category),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Difficulty",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  difficulty,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp)),
        Text(value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
