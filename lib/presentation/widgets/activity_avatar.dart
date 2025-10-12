import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/icons.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? title;

  const CustomCircleAvatar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final activityStyle = (title != null && activityMap.containsKey(title))
        ? activityMap[title]!
        : {
      "icon": Icons.help_outline,
      "color": Colors.grey,
    };

    final icon = activityStyle["icon"] as IconData;
    final color = activityStyle["color"] as Color;

    return CircleAvatar(
      radius: 40.r, // responsive radius
      backgroundColor: color,
      child: Icon(
        icon,
        size: 40.sp, // responsive icon size
        color: Colors.white,
      ),
    );
  }
}
