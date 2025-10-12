import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_route.dart';
import '../../viewmodels/controller/send_mail_controller.dart';
import '../../widgets/show_simple_snack_bar.dart';

class EmailVarificationScreen extends StatelessWidget {
  EmailVarificationScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final SendMailController _sendMailController = Get.put(SendMailController());

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
                    "Reset password",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Enter the email address associated with your account, and we will send you instructions to \nreset your password.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 60.h),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 30.h),

                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: Obx(
                          () => _sendMailController.isLoading.value
                          ? Center(child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: const CircularProgressIndicator(),
                      ))
                          : ElevatedButton(
                        onPressed: () {
                          handleSendMail(context);
                        },
                        child: Text(
                          "Send instructions",
                          style: TextStyle(fontSize: 16.sp),
                        ),
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

  Future<void> handleSendMail(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showSimpleSnackBar(
        context,
        "Email is required",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final success = await _sendMailController.sendMail(email);

    if (success) {
      showSimpleSnackBar(
        context,
        "Failed to send mail",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      Get.toNamed(AppRoutes.pinVarificationScreen);
      showSimpleSnackBar(
        context,
        "Mail sent successfully!",
        bgColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }
}
