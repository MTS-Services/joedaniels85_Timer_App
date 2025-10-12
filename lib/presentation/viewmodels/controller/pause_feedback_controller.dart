import 'package:get/get.dart';
import '../../../core/constants/asset_path.dart';

class PauseFeedbackController extends GetxController {
  var isVisible = true.obs;
  var selectedIndex = RxnInt();

  final List<Map<String, String>> feedbackOptions = [
    {
      "title": "Great",
      "subtitle": "That pause felt refreshing!",
      "icon": AssetPath.starIcon,
    },
    {
      "title": "Okay",
      "subtitle": "It was alright",
      "icon": AssetPath.smileIcon,
    },
    {
      "title": "Sleep Better",
      "subtitle": "Maybe next time will be better",
      "icon": AssetPath.sleepIcon,
    },
  ];

  /// Auto-select feedback based on pause duration in hours
  void autoSelectFeedback(int hours) {
    if (hours >= 8) {
      selectedIndex.value = 0;
    } else if (hours >= 6) {
      selectedIndex.value = 1;
    } else {
      selectedIndex.value = 2;
    }
  }

  void closeFeedback() => isVisible.value = false;
}
