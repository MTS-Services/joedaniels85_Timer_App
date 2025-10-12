import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/data/models/authmodel/otp_model.dart';

import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';

class OtpController extends GetxController {

  final NetworkCaller networkCaller = NetworkCaller();
  var isLoading = false.obs;

  Future<bool> otpVerify(String otp) async {
    if (otp.isEmpty) {
      print("OTP is empty");
      return false;
    }

    isLoading.value = true;

    try {
      final model = OtpModel(code: otp);
      print("Sending payload: ${model.toJson()}");

      final response = await networkCaller.postRequest(
        Urls.completeRegistration,
        model.toJson(),
      );

      // print("POST Status: ${response['status']}");
      // print("POST Response: $response");

      return response['status'] == 'success';
    } catch (e) {
      print("Error in otpVerify: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}