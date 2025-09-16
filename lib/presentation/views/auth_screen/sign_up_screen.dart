import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:joedaniels85_timer_app/routes/app_route.dart';
import '../../../data/services/firebase_services.dart';
import '../../widgets/contine_with.dart';
import '../../widgets/show_simple_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseServices auth = FirebaseServices();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

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
                    "Create new account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Create an account so you can explore all the \nfeatures",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: "Full name"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        handleSignUp(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),

                  // Already have account
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signInScreen);
                    },
                    child: const Text("Already have an account"),
                  ),
                  const SizedBox(height: 15),

                  const ContinueWith(),
                  const SizedBox(height: 15),

                  _customButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          handleGoogleSignIn(context);
        },
        icon: Image.asset(AssetPath.googleLogo, width: 25),
        label: const Text("Sign Up"),
      ),
    );
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      final user = await auth.googleSignIn();

      if (user != null) {

        Get.offNamed(AppRoutes.introScreen);

        showSimpleSnackBar(
          context,
          "Google Sign In Successfully",
          bgColor: Colors.green,
        );
      }
    } catch (e) {
      showSimpleSnackBar(
        context,
        "Google Sign In Failed: $e",
        bgColor: Colors.red,
      );
    }
  }

  Future<void> handleSignUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showSimpleSnackBar(
        context,
        "Email & Password required",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    if (!isValidEmail(email)) {
      showSimpleSnackBar(
        context,
        "Enter a valid email address",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    if (password != _confirmPasswordController.text.trim()) {
      showSimpleSnackBar(
        context,
        "Passwords do not match",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    if (password.length < 6) {
      showSimpleSnackBar(
        context,
        "Password must be at least 6 characters",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    try {
      final user = await auth.signUp(email, password);

      if (user != null) {
        Get.toNamed(AppRoutes.signInScreen);
        showSimpleSnackBar(
          context,
          "Account created successfully!",
          bgColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        showSimpleSnackBar(
          context,
          "Could not sign up",
          bgColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
      showSimpleSnackBar(
        context,
        "Error",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
