// class DurationModel {
//   final String activityId;
//   final int duration;
//   final String? status;
//   final String? notes;
//
//   DurationModel({
//     required this.activityId,
//     required this.duration,
//     this.status,
//     this.notes,
//   });
//
//   factory DurationModel.fromJson(Map<String, dynamic> json) {
//     return DurationModel(
//       activityId: json['activityId'],
//       duration: json['duration'],
//       status: json['status'],
//       notes: json['notes'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'activityId': activityId,
//       'duration': duration,
//       if (status != null) 'status': status,
//       if (notes != null) 'notes': notes,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'ActivityDurationModel(activityId: $activityId, duration: $duration, status: $status, notes: $notes)';
//   }
// }
class DurationModel {
  String activityId;
  int duration;
  String? notes;
  String status;

  DurationModel({
    required this.activityId,
    required this.duration,
    this.notes,
    required this.status,
  });

  // JSON থেকে Dart object এ convert
  factory DurationModel.fromJson(Map<String, dynamic> json) {
    return DurationModel(
      activityId: json['activityId'] as String,
      duration: json['duration'] as int,
      notes: json['notes'] as String,
      status: json['status'] as String,
    );
  }

  // Dart object থেকে JSON এ convert
  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'duration': duration,
      'notes': notes,
      'status': status,
    };
  }

  // Object print করার জন্য
  @override
  String toString() {
    return 'DurationModel(activityId: $activityId, duration: $duration, notes: $notes, status: $status)';
  }
}
