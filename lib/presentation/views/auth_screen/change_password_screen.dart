import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/presentation/viewmodels/controller/change_password_controller.dart';
import '../../../routes/app_route.dart';
import '../../widgets/show_simple_snack_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create a new Password",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Your new password must be different from \npreviously used passwords.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50.h),

                  // 🔹 New Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "New Password",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // 🔹 Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // 🔹 Submit Button / Loading Indicator
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                handleChangePassword(context);
                              },
                              child: Text(
                                "Reset Password",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Handle Change Password Logic
  Future<void> handleChangePassword(BuildContext context) async {
    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty) {
      showSimpleSnackBar(
        context,
        "Password is required",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    if (confirmPassword.isEmpty) {
      showSimpleSnackBar(
        context,
        "Confirm password is required",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    if (newPassword != confirmPassword) {
      showSimpleSnackBar(
        context,
        "Passwords do not match",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    controller.isLoading.value = true;
    final isSuccess = await controller.changePassword(newPassword);
    controller.isLoading.value = false;

    if (!isSuccess) {

      showSimpleSnackBar(
        context,
        "Password changed successfully!",
        bgColor: Colors.green,
        textColor: Colors.white,
      );
      Get.offAllNamed(AppRoutes.signInScreen);
    } else {
      showSimpleSnackBar(
        context,
        "Failed to change password",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
