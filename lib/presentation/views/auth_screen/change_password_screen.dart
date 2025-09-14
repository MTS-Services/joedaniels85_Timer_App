import 'package:flutter/material.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
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
                    "Create a new Password ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Your new password must be different from \npreviously used passwords.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),

                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: "New Password"),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller:_confirmPasswordController ,
                    decoration: const InputDecoration(hintText: "Confirm Password"),
                    obscureText: true,
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text("Reset Password"),
                    ),
                  )

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
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
