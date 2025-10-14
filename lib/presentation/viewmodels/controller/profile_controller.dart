import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../data/models/screenmodel/user_profile_model.dart';

class UserProfileController extends GetxController {
  var profileList = Rxn<UserData>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print("UserProfileController initialized");
    fetchProfile();
  }

  /// Fetch profile from API
  Future<bool> fetchProfile() async {
    isLoading.value = true;
    print("Fetching profile started...");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print("Token from SharedPreferences: $token");

      if (token == null) {
        print("No auth token found.");
        return false;
      }

      final url = "${Urls.baseUrl}/user/profile";
      print("Making GET request to: $url");

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        print("Failed to fetch profile. Status code: ${response.statusCode}");
        return false;
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print("Decoded JSON response: $jsonResponse");

      final data = jsonResponse['data'];
      print("Profile data extracted: $data");

      if (data == null) {
        print("No data found in response.");
        return false;
      }

      profileList.value = UserData.fromJson(data);
      print("Profile set successfully: ${profileList.value}");
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
