import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/icons.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String level;

  const ActivityCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    // Get style from map
    final activityStyle = activityMap[title] ??
        {
          "icon": Icons.help_outline,
          "color": Colors.grey,
        };

    final icon = activityStyle["icon"] as IconData;
    final color = activityStyle["color"] as Color;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 30.r,
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 15.h),
            const Divider(),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15.sp),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      duration,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13.sp),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: difficultyColors[level] ?? Colors.grey,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Text(
                    level,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
