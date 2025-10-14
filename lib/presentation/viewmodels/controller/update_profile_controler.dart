import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/screenmodel/update_profile_image_model.dart';


class UpdateProfileController extends GetxController {
  var profile = Rxn<UpdateProfileModel>();
  var isLoading = false.obs;

  final NetworkCaller networkCaller = NetworkCaller();

  Future<bool> updateProfile({required UpdateProfileModel updatedProfile, File? profilePicFile}) async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        print("No token found.");
        return false;
      }
      Map<String, dynamic> body = updatedProfile.toJson();
      if (profilePicFile != null && profilePicFile.existsSync()) {
        body['profile_pic'] = profilePicFile.path;
      }
      final response = await networkCaller.putRequest(Urls.userProfile, body, token: token);

      if (response != null && response['success'] == true && response['data'] != null) {
        profile.value = UpdateProfileModel.fromJson(response['data']);
        print("Profile updated: ${profile.value}");
        return true;
      } else {
        print("Update failed: ${response['message'] ?? 'Unknown error'}");
        return false;
      }
    } catch (e) {
      print(" Error updating profile: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
