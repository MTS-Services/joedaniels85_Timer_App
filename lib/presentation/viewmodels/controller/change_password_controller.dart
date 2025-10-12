import 'package:get/get.dart';
import '../../../core/network/network_caller.dart';
import '../../../core/constants/urls.dart';
import '../../../data/models/authmodel/change_password_model.dart';


class ChangePasswordController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();
  var isLoading = false.obs;

  Future<bool> changePassword(String newPassword) async {
    if (newPassword.isEmpty) {
      print("New password is empty");
      return false;
    }

    isLoading.value = true;

    try {
      final model = ChangePasswordModel(newPassword: newPassword);
      print("Sending payload: ${model.toJson()}");

      final response = await networkCaller.postRequest(
        Urls.changePassword,
        model.toJson(),
      );

      // print("POST Status: ${response['status']}");
      // print("POST Response: $response");

      return response['status'] == 'success';
    } catch (e) {
      print("Error in changePassword: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
