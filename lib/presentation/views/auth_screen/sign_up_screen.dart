import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:joedaniels85_timer_app/presentation/viewmodels/controller/registration_controller.dart';
import 'package:joedaniels85_timer_app/presentation/widgets/show_simple_snack_bar.dart';
import 'package:joedaniels85_timer_app/routes/app_route.dart';
import '../../../data/services/firebase_services.dart';
import '../../widgets/contine_with.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final RegistrationController controller = Get.put(RegistrationController());
  final FirebaseServices firebaseServices = FirebaseServices();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseServices auth = FirebaseServices();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
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
                    child: Obx(
                      () => controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _handleSignUp,
                              child: const Text("Sign Up"),
                            ),
                    ),
                  ),
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () async {
          try {
            bool isSignedIn = await firebaseServices.googleSignIn();

            if (isSignedIn) {
              final user = auth.currentUser;
              final name = user?.displayName ?? "Google User";
              final email = user?.email ?? "unknown@gmail.com";

              // Call your backend API
              final backendAuthSuccess = await firebaseServices
                  .handleGoogleBackendAuth(name, email);

              if (backendAuthSuccess) {
                Get.offAllNamed(AppRoutes.introScreen);
                showSimpleSnackBar(
                  context,
                  "Signed in successfully!",
                  bgColor: Colors.green,
                  textColor: Colors.white,
                );
              } else {
                showSimpleSnackBar(
                  context,
                  "Failed to connect with server",
                  bgColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            } else {
              showSimpleSnackBar(
                context,
                "Google Sign-In canceled",
                bgColor: Colors.red,
                textColor: Colors.white,
              );
            }
          } catch (e) {
            print("Google Sign-In error: $e");
            showSimpleSnackBar(
              context,
              "Something went wrong. Try again!",
              bgColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        icon: Image.asset(AssetPath.googleLogo, width: 25),
        label: const Text("Sign Up with Google"),
      ),
    );
  }
  void _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    if (password != confirmPassword) {
      showSimpleSnackBar(context, "Passwords do not match");
      return;
    }

    final isSuccess = await controller.registerUser(name, email, password);

    if (isSuccess) {
      Get.offNamed(AppRoutes.registrationCompleteOtp);
      showSimpleSnackBar(context, "Login Successfully", bgColor: Colors.green);
    } else {
      showSimpleSnackBar(
        context,
        "Registration failed. Try again.",
        bgColor: Colors.red,
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
