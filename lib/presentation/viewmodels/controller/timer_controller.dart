import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerController extends GetxController {
  var remainingSeconds = 0.obs;
  var elapsedSeconds = 0.obs;
  var activityId = "".obs;
  var isRunning = false.obs;

  var selectedMinutes = 0.obs;

  Timer? _timer;

  /// Start Timer
  void startTimer({
    required String currentActivityId,
    required int durationInSec,
  }) async {
    activityId.value = currentActivityId;
    remainingSeconds.value = durationInSec; // total seconds (ex: 5 min = 300)
    elapsedSeconds.value = 0;
    isRunning.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activity_id', currentActivityId);

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

  /// Reset Timer
  void resetTimer(int minutes) {
    stopTimer();
    remainingSeconds.value = minutes * 60;
    elapsedSeconds.value = 0;
    isRunning.value = false;
    selectedMinutes.value = minutes;
  }

  /// Stop Timer
  void stopTimer() {
    _timer?.cancel();
    isRunning.value = false;
  }

  /// Get elapsed
  int getElapsedSeconds() {
    return elapsedSeconds.value;
  }

  /// Time for UI
  String get timeString {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  /// Save token
  Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// Load token
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
