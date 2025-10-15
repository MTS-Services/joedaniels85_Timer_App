import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:joedaniels85_timer_app/presentation/viewmodels/controller/otp_controller.dart';

import '../../../core/constants/app_colors.dart';
import '../../../routes/app_route.dart';
import '../../widgets/show_simple_snack_bar.dart';

class OtpVarificationScreen extends StatelessWidget {
  OtpVarificationScreen({super.key});

  TextEditingController otpController = TextEditingController();
  final OtpController otpVaryController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetPath.varifyLogo, height: 200),
                  const SizedBox(height: 50),
                  Text(
                    "Check your email",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "We have sent a password reset link to your \ninbox.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldWidth: 60,
                    borderRadius: BorderRadius.circular(12),
                    showFieldAsBox: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.varifyFill,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    onSubmit: (String verificationCode) {
                      otpController.text = verificationCode;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => otpVaryController.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                handleOtpVerify(context);
                              },
                              child: const Text("Verify"),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleOtpVerify(BuildContext context) async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      showSimpleSnackBar(
        context,
        "OTP is required",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final isVerified = await otpVaryController.otpVerify(otp);

    if (isVerified) {
      showSimpleSnackBar(
        context,
        "Invalid or expired OTP",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      showSimpleSnackBar(
        context,
        "OTP verified successfully!",
        bgColor: Colors.green,
        textColor: Colors.white,
      );
      Get.offAllNamed(AppRoutes.changePasswordScreen);
    }
  }
}
