import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String profileImage;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFF6F8FB),
      surfaceTintColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(profileImage),
          ),
        ),
      ],
      toolbarHeight: 70.h,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
