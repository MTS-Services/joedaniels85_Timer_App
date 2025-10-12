import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/network_caller.dart';
import '../../../data/models/authmodel/sign_in_model.dart';

class SignUPController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  var isLoading = false.obs;

  Future<bool> loginUser(String email, String password) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      isLoading.value = true;


      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) return false;

      final loginUser = SignInModel(email: email, password: password);
      final response = await networkCaller.postRequest(
        Urls.signIn,
        loginUser.toJson(),
      );

      // print("Login API Response: $response");

      if (response != null &&
          (response['status'] == 'success' ||
              response['success'] == true ||
              response['status'] == true)) {

        print("Login successful: $response");

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final token = response['data']?['token'];
        if (token != null) {
          await prefs.setString('auth_token', token);
          print("API Token saved:======= $token");
        } else {
          print("Token not found in response!");
        }
        return true;
      } else {
        print("API login failed: $response");
        return false;
      }

    } catch (e) {
      print("Login failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
