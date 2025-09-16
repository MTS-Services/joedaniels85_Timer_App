import 'package:flutter/material.dart';

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
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    ),
  );
}