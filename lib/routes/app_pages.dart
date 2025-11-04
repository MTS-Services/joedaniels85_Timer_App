import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/timer_screen.dart';
import 'package:joedaniels85_timer_app/presentation/views/auth_screen/email_varificaton_screen.dart';
import 'package:joedaniels85_timer_app/presentation/views/auth_screen/intro_screen.dart';
import '../presentation/views/all_screen/activities_screen.dart';
import '../presentation/views/all_screen/activity_details_screen.dart';
import '../presentation/views/all_screen/analytics_screen.dart';
import '../presentation/views/all_screen/bottom_nav_bar_screen.dart';
import '../presentation/views/all_screen/pause_active_screen.dart';
import '../presentation/views/all_screen/pause_feedback_screen.dart';
import '../presentation/views/all_screen/profile_screen.dart';
import '../presentation/views/all_screen/timer_focus_screen.dart';
import '../presentation/views/auth_screen/change_password_screen.dart';
import '../presentation/views/auth_screen/pin_varification_screen.dart';
import '../presentation/views/auth_screen/registration_complete_otp.dart';
import '../presentation/views/auth_screen/sign_in_screen.dart';
import '../presentation/views/auth_screen/sign_up_screen.dart';
import '../presentation/views/all_screen/startup_screen.dart';
import 'app_route.dart';
class AppPages {
  static const initial = AppRoutes.signInScreen;

  static final routes = [
    GetPage(
      name: AppRoutes.signUpScreen,
      page: () => const SignUpScreen(),
    ),

    GetPage(
      name: AppRoutes.signInScreen,
      page: () => const SignInScreen(),
    ),

    GetPage(
      name: AppRoutes.emailVarificationScreen,
      page: () => EmailVarificationScreen(),
    ),

    GetPage(
      name: AppRoutes.pinVarificationScreen,
      page: () => OtpVarificationScreen(),
    ),

    GetPage(
      name: AppRoutes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.introScreen,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: AppRoutes.tealLoaderScreen,
      page: () => const TealLoaderScreen(),
    ),
    GetPage(
      name: AppRoutes.bottomNavBarScreen,
      page: () =>  BottomNavBarScreen(),
    ),
    GetPage(
      name: AppRoutes.timerScreen,
      page: () =>  TimerScreen(),
    ),
    GetPage(
      name: AppRoutes.bottomNavBarScreen,
      page: () =>  BottomNavBarScreen(),
    ),
    GetPage(
      name: AppRoutes.timerFocusScreen,
      page: () =>  TimerFocusScreen(),
    ),
    GetPage(
      name: AppRoutes.pauseActiveScreen,
      page: () =>  PauseActiveScreen(),
    ),
    GetPage(
      name: AppRoutes.pauseFeedbackScreen,
      page: () =>  PauseFeedbackScreen(),
    ),
    GetPage(
      name: AppRoutes.activitiesScreen,
      page: () => ActivitiesScreen(),
    ),
    GetPage(
      name: AppRoutes.activityDetailsScreen,
      page: () =>  ActivityDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () =>  ProfileScreen(),
    ),

    GetPage(
      name: AppRoutes.registrationCompleteOtp,
      page: () => RegistrationCompleteOtp(),
    ),
    GetPage(
      name: AppRoutes.analyticsScreen,
      page: () => AnalyticsScreen(),
    )
  ];
}
