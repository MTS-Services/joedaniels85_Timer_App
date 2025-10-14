import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/screenmodel/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class UserProfileController extends GetxController {
  var profileList = Rxn<UserData>();
  var isLoading = false.obs;

  final NetworkCaller networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<bool> fetchProfile() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) return false;

      final response = await networkCaller.getRequest(Urls.userProfile, token: token);
      if (response == null) return false;

      final data = response['data'];
      if (data == null) return false;

      profileList.value = UserData.fromJson(data);
      return true;
    } catch (e) {
      print("Error fetching profile: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile({File? profilePicFile}) async {
    if (profileList.value == null) return false;
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null || token.isEmpty) return false;

      var uri = Uri.parse(Urls.userProfile);
      var request = http.MultipartRequest("POST", uri);
      request.headers['Authorization'] = 'Bearer $token';

      if (profilePicFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_pic',
          profilePicFile.path,
        ));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Status: ${response.statusCode}");
      print("Response: $responseBody");

      if (response.statusCode == 200) {
        profileList.update((user) {
          if (user != null) {
            user.profilePic = profilePicFile!.path;
          }
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper function for base64 → MemoryImage conversion
  ImageProvider getProfileImage() {
    final user = profileList.value;
    if (user == null || user.profilePic == null) {
      return const AssetImage("assets/images/default_avatar.png");
    }

    final pic = user.profilePic!;
    if (pic.startsWith("data:image")) {
      final base64Str = pic.split(",").last;
      return MemoryImage(base64Decode(base64Str));
    } else if (pic.startsWith("http")) {
      return NetworkImage(pic);
    } else if (File(pic).existsSync()) {
      return FileImage(File(pic));
    } else {
      return const AssetImage("assets/images/default_avatar.png");
    }
  }
}
