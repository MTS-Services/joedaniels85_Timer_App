class DurationModel {
  final String activityId;
  final int duration;
  final String? status;
  final String? notes;

  DurationModel({
    required this.activityId,
    required this.duration,
    this.status,
    this.notes,
  });

  factory DurationModel.fromJson(Map<String, dynamic> json) {
    return DurationModel(
      activityId: json['activityId'],
      duration: json['duration'],
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'duration': duration,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return 'ActivityDurationModel(activityId: $activityId, duration: $duration, status: $status, notes: $notes)';
  }
}
