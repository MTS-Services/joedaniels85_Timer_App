import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropPauseIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double pauseBarWidth;
  final double pauseBarHeight;

  const DropPauseIcon({
    super.key,
    this.size = 44,
    this.color = Colors.white,
    this.pauseBarWidth = 6,
    this.pauseBarHeight = 18,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Drop outline
          Icon(
            Icons.water_drop_outlined,
            color: color,
            size: size.w,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _pauseBar(),
              SizedBox(width: size * 0.18.w),
              _pauseBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pauseBar() => Container(
    width: pauseBarWidth.w,
    height: pauseBarHeight.h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3.r),
    ),
  );
}
