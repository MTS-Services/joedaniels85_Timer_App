import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final Color bgColor;
  final String imageIcon;
  final bool isActive;

  const AchievementCard({
    super.key,
    required this.title,
    required this.bgColor,
    required this.imageIcon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          )
        ]
            : [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: isActive ? bgColor : bgColor.withAlpha(100),
            child: Image.asset(
              imageIcon,
              width: 30.w,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.black : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
