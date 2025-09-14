import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_route.dart';
class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});
  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}
class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  final TextEditingController _emailController = TextEditingController();
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
                  Text(
                    "Reset password",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Enter the email address associated with your account, and we will send you instructions to \nreset your password.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),

                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                          Get.toNamed(AppRoutes.pinVarificationScreen);
                      },
                      child: const Text("Send instructions"),
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
