import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCard extends StatelessWidget {
  final String dayName;
  final String minutes;
  final String status;
  final Color statusColor;

  const StatusCard({
    super.key,
    required this.dayName,
    required this.minutes,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        leading: CircleAvatar(
          radius: 25.r,
          backgroundColor: statusColor, // এখন dynamic
          child: Icon(Icons.calendar_month_outlined, color: Colors.white, size: 20.sp),
        ),
        title: Text(
          dayName,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
        ),
        subtitle: Text(
          minutes,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp),
        ),
        trailing: Container(
          height: 30.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Text(
              status,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
