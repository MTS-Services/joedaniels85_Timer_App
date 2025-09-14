import 'package:flutter/material.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/profile_screen.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/task_screen.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/timer_screen.dart';
import '../../widgets/custome_app_bar.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'activities_screen.dart';
import 'analytics_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const TimerScreen(),
    const AnalyticsScreen(),
    const TaskScreen(),
    const ActivitiesScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectedIndex == 1 || _selectedIndex == 3 || _selectedIndex == 4)
          ? null
          : const CustomAppBar(
        title: "Hi Joe",
        subtitle: "Ready for a screen-free evening?",
        profileImage: AssetPath.profile,
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavScreen(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
