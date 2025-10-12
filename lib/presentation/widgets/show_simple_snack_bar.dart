import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSimpleSnackBar(
    BuildContext context,
    String message, {
      Color bgColor = Colors.black,
      Color textColor = Colors.white,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: textColor,
          fontSize: 14.sp, // responsive font size
          fontWeight: FontWeight.normal,
        ),
      ),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)), // responsive radius
      margin: EdgeInsets.all(12.w), // responsive margin
      duration: const Duration(seconds: 3),
    ),
  );
}
