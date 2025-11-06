import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/screenmodel/duration_model.dart';

class DurationController extends GetxController {
  final NetworkCaller networkCaller = NetworkCaller();

  var isLoading = false.obs;

  Future<bool> sendDuration(DurationModel durationModel) async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print("token======$token");
      if (token == null) {
        print("No token found! Please login first.");
        return false;
      }
      final response = await networkCaller.postRequest(
        Urls.submitDuration,
        durationModel.toJson(),
        token: token,
      );
      print("response ===== $response");
      if (response != null &&
          (response['status'] == 'success' ||
              response['success'] == true ||
              response['status'] == true)) {
        print("Duration sent successfully: $response");
        return true;
      } else {
        print("Failed to send duration: $response");
        return false;
      }
    } catch (e) {
      print("Error sending duration: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
