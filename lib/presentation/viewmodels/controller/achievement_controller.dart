import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/network_caller.dart';
import '../../../core/constants/urls.dart';
import '../../../data/models/screenmodel/achievement_aesponse_model.dart';

class AchievementController extends GetxController {
  var isLoading = false.obs;
  var nextAchievements = <Achievement>[].obs;
  var unlockedAchievements = <Achievement>[].obs;
  final NetworkCaller networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    print("AchievementController initialized.");
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    print("fetchActivities started.");
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null || token.isEmpty) {
        print("No API token found. Please login first.");
        isLoading.value = false;
        return;
      }

      final response = await networkCaller.getRequest(
        Urls.achievements,
        token: token,
      );

      // print("API Response: $response");

      if (response != null && response['success'] == true) {
        final achievementResponse = AchievementResponse.fromJson(response);
        nextAchievements.value = achievementResponse.data.nextAchievements;
        unlockedAchievements.value = achievementResponse.data.unlockedAchievements;

        print("Next Achievements loaded: ${nextAchievements.length}");
        print("Unlocked Achievements loaded: ${unlockedAchievements.length}");
      } else {
        print("Failed to load achievements. Message: ${response?['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      print('Error fetching activities: $e');
    } finally {
      isLoading.value = false;
      print("fetchActivities finished.");
    }
  }
}
