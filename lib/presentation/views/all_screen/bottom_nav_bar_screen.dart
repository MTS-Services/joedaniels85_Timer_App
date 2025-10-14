import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/profile_screen.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/task_screen.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/timer_screen.dart';
import '../../viewmodels/controller/profile_controller.dart';
import '../../widgets/custome_app_bar.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'activities_screen.dart';
import 'analytics_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  BottomNavBarScreen({super.key});

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

  late final List<Widget> _pages = [
    TimerScreen(),
    AnalyticsScreen(),
    TaskScreen(),
    ActivitiesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: (_selectedIndex == 1 || _selectedIndex == 3 || _selectedIndex == 4)
            ? null
            : CustomAppBar(
          subtitle: "Ready for a screen-free evening?",
        ),
        body: SafeArea(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: CustomBottomNavScreen(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
      );
  }
}
