
import 'activity.dart';

class ActivitiesModel {
  final bool success;
  final List<Activity> data;
  final String message;

  ActivitiesModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data.map((a) => a.toJson()).toList(),
    'message': message,
  };
}