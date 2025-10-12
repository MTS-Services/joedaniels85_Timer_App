class ProgressResponse {
  final bool success;
  final ProgressData? data;
  final String? message;

  ProgressResponse({required this.success, this.data, this.message});

  factory ProgressResponse.fromJson(Map<String, dynamic> json) => ProgressResponse(
    success: json['success'] == true,
    data: json['data'] != null ? ProgressData.fromJson(json['data']) : null,
    message: json['message'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.toJson(),
    'message': message,
  };

  @override
  String toString() => 'ProgressResponse(success: $success, data: $data, message: $message)';
}

class ProgressData {
  final PeriodSummary? today;
  final SimplePeriod? thisWeek;
  final SimplePeriod? thisMonth;
  final Overall? overall;
  final List<CategoryBreakdown>? categoryBreakdown;
  final int? currentStreak;

  ProgressData({
    this.today,
    this.thisWeek,
    this.thisMonth,
    this.overall,
    this.categoryBreakdown,
    this.currentStreak,
  });

  factory ProgressData.fromJson(Map<String, dynamic> json) => ProgressData(
    today: json['today'] != null ? PeriodSummary.fromJson(json['today']) : null,
    thisWeek: json['thisWeek'] != null ? SimplePeriod.fromJson(json['thisWeek']) : null,
    thisMonth: json['thisMonth'] != null ? SimplePeriod.fromJson(json['thisMonth']) : null,
    overall: json['overall'] != null ? Overall.fromJson(json['overall']) : null,
    categoryBreakdown: json['categoryBreakdown'] != null
        ? List<CategoryBreakdown>.from(
        json['categoryBreakdown'].map((x) => CategoryBreakdown.fromJson(x)))
        : [],
    currentStreak: json['currentStreak'],
  );

  Map<String, dynamic> toJson() => {
    'today': today?.toJson(),
    'thisWeek': thisWeek?.toJson(),
    'thisMonth': thisMonth?.toJson(),
    'overall': overall?.toJson(),
    'categoryBreakdown': categoryBreakdown?.map((x) => x.toJson()).toList(),
    'currentStreak': currentStreak,
  };

  @override
  String toString() =>
      'ProgressData(today: $today, thisWeek: $thisWeek, thisMonth: $thisMonth, overall: $overall, categoryBreakdown: $categoryBreakdown, currentStreak: $currentStreak)';
}

class PeriodSummary {
  final int? activitiesCount;
  final int? completedCount;
  final int? totalDuration;
  final List<ActivityEntry>? activities;

  PeriodSummary({this.activitiesCount, this.completedCount, this.totalDuration, this.activities});

  factory PeriodSummary.fromJson(Map<String, dynamic> json) => PeriodSummary(
    activitiesCount: json['activitiesCount'],
    completedCount: json['completedCount'],
    totalDuration: json['totalDuration'],
    activities: json['activities'] != null
        ? List<ActivityEntry>.from(json['activities'].map((x) => ActivityEntry.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'activitiesCount': activitiesCount,
    'completedCount': completedCount,
    'totalDuration': totalDuration,
    'activities': activities?.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() =>
      'PeriodSummary(activitiesCount: $activitiesCount, completedCount: $completedCount, totalDuration: $totalDuration, activities: $activities)';
}

class ActivityEntry {
  final String? id;
  final String? userId;
  final String? activityId;
  final int? duration;
  final String? status;
  final String? notes;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Activity? activity;

  ActivityEntry({
    this.id,
    this.userId,
    this.activityId,
    this.duration,
    this.status,
    this.notes,
    this.startedAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.activity,
  });

  factory ActivityEntry.fromJson(Map<String, dynamic> json) => ActivityEntry(
    id: json['id'],
    userId: json['userId'],
    activityId: json['activityId'],
    duration: json['duration'],
    status: json['status'],
    notes: json['notes'],
    startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
    completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    activity: json['activity'] != null ? Activity.fromJson(json['activity']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'activityId': activityId,
    'duration': duration,
    'status': status,
    'notes': notes,
    'startedAt': startedAt?.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'activity': activity?.toJson(),
  };

  @override
  String toString() =>
      'ActivityEntry(id: $id, userId: $userId, activityId: $activityId, duration: $duration, status: $status, notes: $notes, startedAt: $startedAt, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, activity: $activity)';
}

class Activity {
  final String? id;
  final String? icon;
  final String? title;
  final String? category;
  final String? difficulty;
  final String? duration;
  final String? description;
  final List<String>? benefits;
  final List<String>? howToStart;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Activity({
    this.id,
    this.icon,
    this.title,
    this.category,
    this.difficulty,
    this.duration,
    this.description,
    this.benefits,
    this.howToStart,
    this.createdAt,
    this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json['id'],
    icon: json['icon'],
    title: json['title'],
    category: json['category'],
    difficulty: json['difficulty'],
    duration: json['duration'],
    description: json['description'],
    benefits: json['benefits'] != null ? List<String>.from(json['benefits']) : [],
    howToStart: json['howToStart'] != null ? List<String>.from(json['howToStart']) : [],
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'icon': icon,
    'title': title,
    'category': category,
    'difficulty': difficulty,
    'duration': duration,
    'description': description,
    'benefits': benefits,
    'howToStart': howToStart,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  @override
  String toString() => 'Activity(id: $id, title: $title, category: $category, difficulty: $difficulty, duration: $duration)';
}

class SimplePeriod {
  final int? activitiesCount;
  final int? completedCount;
  final int? totalDuration;

  SimplePeriod({this.activitiesCount, this.completedCount, this.totalDuration});

  factory SimplePeriod.fromJson(Map<String, dynamic> json) => SimplePeriod(
    activitiesCount: json['activitiesCount'],
    completedCount: json['completedCount'],
    totalDuration: json['totalDuration'],
  );

  Map<String, dynamic> toJson() => {
    'activitiesCount': activitiesCount,
    'completedCount': completedCount,
    'totalDuration': totalDuration,
  };

  @override
  String toString() =>
      'SimplePeriod(activitiesCount: $activitiesCount, completedCount: $completedCount, totalDuration: $totalDuration)';
}

class Overall {
  final int? totalActivities;
  final int? completedActivities;
  final int? totalDurationMinutes;
  final int? activitiesByCategory;

  Overall({this.totalActivities, this.completedActivities, this.totalDurationMinutes, this.activitiesByCategory});

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    totalActivities: json['totalActivities'],
    completedActivities: json['completedActivities'],
    totalDurationMinutes: json['totalDurationMinutes'],
    activitiesByCategory: json['activitiesByCategory'],
  );

  Map<String, dynamic> toJson() => {
    'totalActivities': totalActivities,
    'completedActivities': completedActivities,
    'totalDurationMinutes': totalDurationMinutes,
    'activitiesByCategory': activitiesByCategory,
  };

  @override
  String toString() =>
      'Overall(totalActivities: $totalActivities, completedActivities: $completedActivities, totalDurationMinutes: $totalDurationMinutes, activitiesByCategory: $activitiesByCategory)';
}

class CategoryBreakdown {
  final String? category;
  final String? title;
  final int? count;
  final int? totalDuration;

  CategoryBreakdown({this.category, this.title, this.count, this.totalDuration});

  factory CategoryBreakdown.fromJson(Map<String, dynamic> json) => CategoryBreakdown(
    category: json['category'],
    title: json['title'],
    count: json['count'],
    totalDuration: json['totalDuration'],
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'title': title,
    'count': count,
    'totalDuration': totalDuration,
  };

  @override
  String toString() =>
      'CategoryBreakdown(category: $category, title: $title, count: $count, totalDuration: $totalDuration)';
}
