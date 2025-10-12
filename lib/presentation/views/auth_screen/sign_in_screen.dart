import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import '../../../data/services/firebase_services.dart';
import '../../../routes/app_route.dart';
import '../../viewmodels/controller/sign_in_controller.dart';
import '../../widgets/contine_with.dart';
import '../../widgets/show_simple_snack_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignUPController signUPController = Get.put(SignUPController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseServices firebaseServices = FirebaseServices();
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
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.emailVarificationScreen);
                        },
                        child: Text("Forgot your password?"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return signUPController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () {
                          handleSignIn(context);
                        },
                        child: const Text("Sign In"),
                      );
                    }),
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
                  _customButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSignIn(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showSimpleSnackBar(
        context,
        "Email & Password required",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      final isLoggedIn = await signUPController.loginUser(email, password);

      if (isLoggedIn) {
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
          "Invalid email or password",
          bgColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Sign-in error: $e");
      showSimpleSnackBar(
        context,
        "Something went wrong. Try again!",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
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
        onPressed: () async {
          try {
            bool isSignedIn = await firebaseServices.googleSignIn();
            if (isSignedIn) {
              Get.offAllNamed(AppRoutes.introScreen); // Homepage এ পাঠানো
              showSimpleSnackBar(
                context,
                "Signed in successfully!",
                bgColor: Colors.green,
                textColor: Colors.white,
              );
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
        label: const Text("Sign In with Google"),
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
