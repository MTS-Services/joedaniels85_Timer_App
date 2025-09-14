import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import '../../../routes/app_route.dart';
import '../../widgets/contine_with.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                    "Login here",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Welcome back you've been missed!",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  const SizedBox(height: 50),

                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: "Password"),
                    obscureText: true,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        Get.toNamed(AppRoutes.emailVarificationScreen);
                      }, child: Text("Forgot your password?"))
                    ],
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.introScreen);
                      },
                      child: const Text("Sign In"),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: const Text("Create a new account"),
                  ),

                  const SizedBox(height: 15),
                  const ContinueWith(),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: AppColors.primary, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      icon: Image.asset(AssetPath.googleLogo, width: 25),
                      label: const Text("Sign In"),
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
    _passwordController.dispose();
    super.dispose();
  }
}
