import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/authmodel/registration_complete_model.dart';

class RegistrationCompleteController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  var isLoading = false.obs;

  Future<bool> completeRegistration(String otp) async {
    isLoading.value = true;
    try {
      if (otp.isEmpty) {
        print("Email or OTP is empty");
        return false;
      }

      // Model
      final model = RegistrationCompleteModel(code: otp);
      print("Sending payload: ${model.toJson()}");

      final response = await networkCaller.postRequest(
        Urls.completeRegistration,
        model.toJson(),
      );
      //
      // print("POST Status: ${response['status']}");
      // print("POST Response: $response");

      if (response['status'] == 'success') {
        return true;
      } else {
        print("Server message: ${response['message']}");
        return false;
      }
    } catch (e) {
      print("Error in completeRegistration: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
