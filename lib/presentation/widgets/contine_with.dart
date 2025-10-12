import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1.h,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Text(
            "Or continue with",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13.sp,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1.h,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
