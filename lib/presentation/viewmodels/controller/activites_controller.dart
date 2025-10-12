import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/network_caller.dart';
import '../../../core/constants/urls.dart';
import '../../../data/models/screenmodel/activity.dart';

class ActivitiesController extends GetxController {
  var isLoading = false.obs;
  var activitiesList = <Activity>[].obs;
  final NetworkCaller networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        print("No API token found. Please login first.");
        isLoading.value = false;
        return;
      }

      print("Using API Token: $token");
      print("Sending GET request to: ${Urls.getActivities}");

      final response = await networkCaller.getRequest(
        Urls.getActivities,
        token: token,
      );

      // print("response ==  $response");

      if (response != null && response['data'] != null) {
        final data = response['data'] as List;
        activitiesList.value =
            data.map((json) => Activity.fromJson(json)).toList();
        print("Activities loaded: ${activitiesList.length}");
      } else if (response != null && response['message'] != null) {
        print("API Error Message: ${response['message']}");
      } else {
        print("Failed to load activities: $response");
      }
    } catch (e) {
      print('Error fetching activities: $e');
    } finally {
      isLoading.value = false;
      print("fetchActivities finished.");
    }
  }

}
