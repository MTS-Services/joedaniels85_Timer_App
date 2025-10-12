import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/screenmodel/user_profile_model.dart';

class UserProfileController extends GetxController {
  var profileList = <UserData>[].obs;
  var isLoading = false.obs;

  final NetworkCaller networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<bool> fetchProfile() async {
    isLoading.value = true;
    print("Fetching profile...");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print("Token from SharedPreferences: $token");

      if (token == null) {
        print("❌ No token found in SharedPreferences!");
        return false;
      }

      print("✅ Token exists, making API call...");
      final response = await networkCaller.getRequest(
        Urls.userProfile,
        token: token,
      );

      print("API Response: $response");

      if (response == null) {
        print("API returned null");
        return false;
      }

      final isSuccess = response['status'] == 'success' ||
          response['success'] == true ||
          response['status'] == true;

      print("API success status: $isSuccess");

      if (!isSuccess) {
        print("API returned unsuccessful status");
        return false;
      }

      final data = response['data'];
      if (data == null) {
        print("No profile data found in API response");
        return false;
      }

      // Correct way to assign profile
      final userData = UserData.fromJson(data);
      profileList.assignAll([userData]);

      print("✅ Profile fetched successfully!");
      print("Profile Name: ${profileList.first.name}");
      print("Profile Email: ${profileList.first.email}");
      print("Profile ID: ${profileList.first.id}");

      return true;
    } catch (e) {
      print("Error fetching profile: $e");
      return false;
    } finally {
      isLoading.value = false;
      print("Fetching profile finished. isLoading: ${isLoading.value}");
    }
  }
}
