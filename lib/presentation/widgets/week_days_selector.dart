import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class WeekDaysSelector extends StatelessWidget {
  final List<String> days;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;
  final TextStyle? textStyle;
  final void Function(String day)? onDaySelected;

  const WeekDaysSelector({
    super.key,
    required this.days,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.height = 60,
    this.width = 50,
    this.borderRadius = 6,
    this.textStyle,
    this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (onDaySelected != null) {
                onDaySelected!(days[index]);
              }
            },
            child: Container(
              width: width.w,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius.r),
              ),
              child: Center(
                child: Text(
                  days[index],
                  style: textStyle ??
                      TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
