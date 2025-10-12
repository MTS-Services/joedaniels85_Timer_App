import 'package:get/get.dart';
import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/authmodel/send_mail_model.dart';

class SendMailController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  var isLoading = false.obs;

  Future<bool> sendMail(String email) async {
    isLoading.value = true;
    try {
      if (email.isEmpty) {
        print("Email is empty");
        return false;
      }

      final model = SendMailModel(email: email);
      print("Sending payload: ${model.toJson()}");

      final response = await networkCaller.postRequest(
        Urls.sendMail,
        model.toJson(),
      );

      // print("POST Status: ${response['status']}");
      // print("POST Response: $response");

      if (response['status'] == 'success') {
        return true;
      } else {
        print("Server message: ${response['message']}");
        return false;
      }
    } catch (e) {
      print("Error in sendMail: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
