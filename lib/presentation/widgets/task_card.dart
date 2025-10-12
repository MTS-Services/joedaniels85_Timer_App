import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class ActionIcon {
  final IconData? icon;
  final String? imagePath;
  final Color color;
  final VoidCallback onTap;

  ActionIcon({
    this.icon,
    this.imagePath,
    required this.color,
    required this.onTap,
  });
}

class TaskCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final IconData? leadingIcon;
  final Color leadingBgColor;
  final List<ActionIcon>? actions;
  final String subTitle;
  final double size;
  final FontWeight? fontWeight;
  final double cardEle;
  final Color iconColor;

  const TaskCard({
    super.key,
    required this.title,
    this.imagePath,
    this.leadingIcon,
    this.leadingBgColor = AppColors.primary,
    this.actions,
    this.subTitle = "",
    this.size = 15,
    this.fontWeight = FontWeight.bold,
    this.cardEle = 0,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardEle,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
          leading: (imagePath != null || leadingIcon != null)
              ? CircleAvatar(
            radius: 22.r,
            backgroundColor: leadingBgColor,
            child: imagePath != null
                ? Image.asset(
              imagePath!,
              height: 24.h,
              width: 24.w,
              color: iconColor,
            )
                : Icon(
              leadingIcon,
              color: iconColor,
              size: 24.sp,
            ),
          )
              : null,
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: size.sp,
              fontWeight: fontWeight,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 14.sp),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: actions != null
                ? actions!
                .map((action) => GestureDetector(
              onTap: action.onTap,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 4.w),
                child: action.imagePath != null
                    ? Image.asset(
                  action.imagePath!,
                  height: 24.h,
                  width: 24.w,
                  color: action.color,
                )
                    : Icon(action.icon,
                    color: action.color, size: 24.sp),
              ),
            ))
                .toList()
                : [],
          ),
        ),
      ),
    );
  }
}
