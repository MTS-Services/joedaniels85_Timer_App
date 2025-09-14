import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:joedaniels85_timer_app/routes/app_pages.dart';
import 'package:joedaniels85_timer_app/routes/app_route.dart';

import 'core/constants/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signUpScreen,
      getPages: AppPages.routes,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF6F8FB),
        textTheme: _buildTextTheme(),
        inputDecorationTheme: _buildInputDecorationTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        )
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
          fillColor: AppColors.secondary,
          filled: true,
           border: OutlineInputBorder(
             borderSide: BorderSide.none,
           ),
        contentPadding: EdgeInsets.all(8),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)
        ),
      );
  }

  TextTheme _buildTextTheme() {
    return TextTheme(
        bodyMedium: TextStyle(fontSize: 25 , fontWeight:  FontWeight.bold),
        bodySmall: TextStyle(fontSize: 16 , fontWeight: FontWeight.normal , color: Colors.grey.shade700),
      );
  }
}
