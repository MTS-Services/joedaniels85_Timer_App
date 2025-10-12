import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/asset_path.dart';
import '../../../routes/app_route.dart';
import '../../viewmodels/controller/registration_complete_controller.dart';
import '../../widgets/show_simple_snack_bar.dart';

class RegistrationCompleteOtp extends StatelessWidget {
  RegistrationCompleteOtp({super.key});

  final RegistrationCompleteController registrationComp =
      RegistrationCompleteController();
  final TextEditingController otpController = TextEditingController();

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
                    "Registration Successful",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please check your email to complete the \nregistration.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
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
                      () => registrationComp.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                completeRegistrationAndNavigate(context);
                              },
                              child: const Text("Registration complete"),
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

  Future<void> completeRegistrationAndNavigate(BuildContext context) async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      showSimpleSnackBar(context, "OTP is required", bgColor: Colors.red);
      return;
    }

    final isVerified = await registrationComp.completeRegistration(otp);

    if (!isVerified) {
      Get.toNamed(AppRoutes.signInScreen);
      showSimpleSnackBar(
        context,
        "Registration completed",
        bgColor: Colors.green,
      );
    } else {
      showSimpleSnackBar(
        context,
        "OTP verification failed or expired",
        bgColor: Colors.red,
      );
    }
  }
}
