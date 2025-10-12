import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';

class CustomBottomNavScreen extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavScreen({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.timer,
            color: currentIndex == 0 ? Colors.black : Colors.grey,
            width: 25.w,
          ),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.chartIcon,
            color: currentIndex == 1 ? Colors.black : Colors.grey,
            width: 25.w,
          ),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.playIcon,
            color: currentIndex == 2 ? Colors.black : Colors.grey,
            width: 25.w,
          ),
          label: 'Pause',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.bookOpen,
            color: currentIndex == 3 ? Colors.black : Colors.grey,
            width: 25.w,
          ),
          label: 'Activities',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.user,
            color: currentIndex == 4 ? Colors.black : Colors.grey,
            width: 25.w,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
