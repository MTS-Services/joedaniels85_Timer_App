import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/data/models/authmodel/registration_model.dart';
import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';

class RegistrationController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  var isLoading = false.obs;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<bool> registerUser(String name, String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = userCredential.user?.uid;
      if (uid == null) return false;
      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) return false;
      RegistrationModel createUser = RegistrationModel(
        name: name,
        email: email,
        password: password,
      );
      final response = await networkCaller.postRequest(
        Urls.registration,
        createUser.toJson(),
        token: idToken,
      );
      if (response != null &&
          (response['status'] == 'success' ||
              response['success'] == true ||
              response['status'] == true)) {
        print("Registration successful: $response");
        return true;
      } else {
        print("API registration failed: $response");
        await userCredential.user?.delete();
        return false;
      }
    } catch (e) {
      print("Registration failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUser() async {
    final response = await networkCaller.getRequest(Urls.registration);

    if (response != null) {
      final Map<String, dynamic> data = response;

      // প্রথম ইউজার
      RegistrationModel user = RegistrationModel.fromJson(data[0]);

      print("Name: ${user.getName}");
    } else {
      print("Failed to fetch data");
    }
  }





}
