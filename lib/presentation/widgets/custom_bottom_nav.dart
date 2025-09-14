import 'package:flutter/material.dart';
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
          icon: Image.asset(AssetPath.timer,color: Colors.black , width: 30,),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(AssetPath.chartIcon ,color: Colors.black, width: 30,),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(AssetPath.playIcon, color: Colors.black, width: 30,),
          label: 'Pause',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(AssetPath.bookOpen, color: Colors.black, width: 30,),
          label: 'Activities',
        ),
        BottomNavigationBarItem(
          icon:Image.asset(AssetPath.user, color: Colors.black, width: 30,),
          label: 'Profile',
        ),
      ],
    );
  }
}
