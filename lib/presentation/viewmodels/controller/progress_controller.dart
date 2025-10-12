import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/screenmodel/progress_pesponse_model.dart';

class UserProgressController extends GetxController {
  var isLoading = false.obs;
  var progressResponse = Rxn<ProgressResponse>();
  var todayActivities = <ActivityEntry>[].obs;
  var categoryBreakdownList = <CategoryBreakdown>[].obs;
  var overallStats = Rxn<Overall>();

  final NetworkCaller networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchUserProgress();
  }

  Future<void> fetchUserProgress() async {
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
        Urls.progress,
        token: token,
      );

      if (response != null && response['success'] == true) {
        final parsed = ProgressResponse.fromJson(response);
        progressResponse.value = parsed;
        todayActivities.value = parsed.data?.today?.activities ?? [];
        categoryBreakdownList.value = parsed.data?.categoryBreakdown ?? [];
        overallStats.value = parsed.data?.overall; // ✅ set overall data

        print("Overall Stats: ${overallStats.value}");
      } else {
        print("API Error or no data: $response");
      }
    } catch (e) {
      print("Error fetching progress: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
