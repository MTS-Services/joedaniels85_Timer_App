import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';
import '../../../core/network/network_caller.dart';
import '../../../data/models/screenmodel/progress_response_model.dart';

class UserProgressController extends GetxController {
  var isLoading = false.obs;

  /// Full API response model
  var progress = Rxn<ProgressResponse>();

  /// Weekly Progress list
  var weeklyProgress = <WeeklyProgress>[].obs;

  /// Summary parts
  var todaySummary = Rxn<SummaryStats>();
  var last7Summary = Rxn<SummaryStats>();
  var last30Summary = Rxn<SummaryStats>();
  var overallSummary = Rxn<Overall>();
  var dailyProgress = Rxn<DailyProgress>();

  /// Streaks
  var streakCurrent = 0.obs;
  var streakLongest = 0.obs;

  final NetworkCaller networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchProgress();
  }

  Future<void> fetchProgress() async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        print("Token not found");
        return;
      }

      final response = await networkCaller.getRequest(
        Urls.progress,
        token: token,
      );

      if (response != null && response["success"] == true) {
        final parsed = ProgressResponse.fromJson(response);
        progress.value = parsed;

        /// Weekly Progress (sort Sun → Sat)
        weeklyProgress.value = parsed.data.weeklyProgress
          ..sort((a, b) => a.dayIndex.compareTo(b.dayIndex));

        /// Summary
        todaySummary.value = parsed.data.summary.today;
        last7Summary.value = parsed.data.summary.last7Days;
        last30Summary.value = parsed.data.summary.last30Days;
        overallSummary.value = parsed.data.summary.overall;

        /// Daily Progress
        dailyProgress.value = parsed.data.dailyProgress.isNotEmpty
            ? parsed.data.dailyProgress.first
            : null;

        /// Streaks
        streakCurrent.value = parsed.data.streaks.current;
        streakLongest.value = parsed.data.streaks.longest;

        print("Progress loaded successfully");
      } else {
        print("API Error: $response");
      }
    } catch (e) {
      print("Error fetching progress: $e");
    } finally {
      isLoading.value = false;
    }
  }


  List<String> get dayList {
    return const ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  }

  List<int> get durationList {
    List<int> fixed = List.filled(7, 0);

    for (var item in weeklyProgress) {
      fixed[item.dayIndex] = item.duration;
    }

    return fixed;
  }
}
