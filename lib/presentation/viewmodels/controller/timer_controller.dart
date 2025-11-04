import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerController extends GetxController {
  var remainingSeconds = 0.obs;
  var elapsedSeconds = 0.obs;
  var activityId = "".obs;
  var isRunning = false.obs;

  Timer? _timer;

  /// Start Timer & Save activityId
  void startTimer({required String currentActivityId, required int durationInSec}) async {
    activityId.value = currentActivityId;
    remainingSeconds.value = durationInSec;
    elapsedSeconds.value = 0;
    isRunning.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activity_id', currentActivityId);
    print("✅ Saved activityId: $currentActivityId");

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        elapsedSeconds.value++;
      } else {
        stopTimer();
      }
    });
  }

  void resetTimer(int minutes) {
    stopTimer();
    remainingSeconds.value = minutes * 60;
    elapsedSeconds.value = 0;
    isRunning.value = false;
  }

  /// Stop timer
  void stopTimer() {
    _timer?.cancel();
    isRunning.value = false;
  }

  /// Get elapsed seconds
  int getElapsedSeconds() {
    return elapsedSeconds.value;
  }

  /// Time string for UI
  String get timeString {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  /// ✅ Save token (when login)
  Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    print("✅ Saved auth_token: $token");
  }

  /// ✅ Load token
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
