import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joedaniels85_timer_app/routes/app_pages.dart';
import 'package:joedaniels85_timer_app/routes/app_route.dart';
import 'core/constants/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: user != null
              ? AppRoutes.bottomNavBarScreen
              : AppRoutes.signInScreen,
          getPages: AppPages.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: _buildTextTheme(),
            inputDecorationTheme: _buildInputDecorationTheme(),
            elevatedButtonTheme: _buildElevatedButtonThemeData(),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
        );
      },
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: AppColors.secondary,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.all(8.w),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  TextTheme _buildTextTheme() {
    return TextTheme(
      bodyMedium: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade700,
      ),
    );
  }
}
