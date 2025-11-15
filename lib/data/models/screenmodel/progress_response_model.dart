import 'dart:convert';

ProgressResponse progressResponseFromJson(String str) =>
    ProgressResponse.fromJson(json.decode(str));

class ProgressResponse {
  final bool success;
  final ProgressData data;
  final String message;

  ProgressResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ProgressResponse.fromJson(Map<String, dynamic> json) =>
      ProgressResponse(
        success: json["success"],
        data: ProgressData.fromJson(json["data"]),
        message: json["message"],
      );
}

class ProgressData {
  final List<DailyProgress> dailyProgress;
  final List<WeeklyProgress> weeklyProgress;
  final Summary summary;
  final List<CategoryBreakdown> categoryBreakdown;
  final Streaks streaks;
  final int totalDays;

  ProgressData({
    required this.dailyProgress,
    required this.weeklyProgress,
    required this.summary,
    required this.categoryBreakdown,
    required this.streaks,
    required this.totalDays,
  });

  factory ProgressData.fromJson(Map<String, dynamic> json) => ProgressData(
    dailyProgress: List.from(json["dailyProgress"])
        .map((x) => DailyProgress.fromJson(x))
        .toList(),
    weeklyProgress: List.from(json["weekly_progress"])
        .map((x) => WeeklyProgress.fromJson(x))
        .toList(),
    summary: Summary.fromJson(json["summary"]),
    categoryBreakdown: List.from(json["categoryBreakdown"])
        .map((x) => CategoryBreakdown.fromJson(x))
        .toList(),
    streaks: Streaks.fromJson(json["streaks"]),
    totalDays: json["totalDays"],
  );
}

// ---------------- DAILY PROGRESS -----------------

class DailyProgress {
  final String date;
  final String dayName;
  final String fullDate;
  final Stats stats;
  final List<ActivityEntry> activities;

  DailyProgress({
    required this.date,
    required this.dayName,
    required this.fullDate,
    required this.stats,
    required this.activities,
  });

  factory DailyProgress.fromJson(Map<String, dynamic> json) => DailyProgress(
    date: json["date"],
    dayName: json["dayName"],
    fullDate: json["fullDate"],
    stats: Stats.fromJson(json["stats"]),
    activities: List.from(json["activities"])
        .map((x) => ActivityEntry.fromJson(x))
        .toList(),
  );
}

// ---------------- STATS -----------------

class Stats {
  final int total;
  final int completed;
  final int inProgress;
  final int planned;
  final int cancelled;
  final int paused;
  final int totalDuration;
  final String totalDurationFormatted;
  final int completionRate;

  Stats({
    required this.total,
    required this.completed,
    required this.inProgress,
    required this.planned,
    required this.cancelled,
    required this.paused,
    required this.totalDuration,
    required this.totalDurationFormatted,
    required this.completionRate,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    total: json["total"],
    completed: json["completed"],
    inProgress: json["inProgress"],
    planned: json["planned"],
    cancelled: json["cancelled"],
    paused: json["paused"],
    totalDuration: json["totalDuration"],
    totalDurationFormatted: json["totalDurationFormatted"],
    completionRate: json["completionRate"],
  );
}

// ---------------- ACTIVITY ENTRY -----------------

class ActivityEntry {
  final String id;
  final String userId;
  final String activityId;
  final int duration;
  final String status;
  final String? notes;
  final String? startedAt;
  final String? completedAt;
  final String createdAt;
  final String updatedAt;
  final ActivityDetails activity;

  ActivityEntry({
    required this.id,
    required this.userId,
    required this.activityId,
    required this.duration,
    required this.status,
    required this.notes,
    required this.startedAt,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.activity,
  });

  factory ActivityEntry.fromJson(Map<String, dynamic> json) => ActivityEntry(
    id: json["id"],
    userId: json["userId"],
    activityId: json["activityId"],
    duration: json["duration"],
    status: json["status"],
    notes: json["notes"],
    startedAt: json["startedAt"],
    completedAt: json["completedAt"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    activity: ActivityDetails.fromJson(json["activity"]),
  );
}

// ----------- ACTIVITY DETAILS -----------------

class ActivityDetails {
  final String id;
  final String icon;
  final String title;
  final String category;
  final String difficulty;
  final String duration;
  final String description;
  final List<String> benefits;
  final List<String> howToStart;
  final String createdAt;
  final String updatedAt;

  ActivityDetails({
    required this.id,
    required this.icon,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.description,
    required this.benefits,
    required this.howToStart,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ActivityDetails.fromJson(Map<String, dynamic> json) =>
      ActivityDetails(
        id: json["id"],
        icon: json["icon"],
        title: json["title"],
        category: json["category"],
        difficulty: json["difficulty"],
        duration: json["duration"],
        description: json["description"],
        benefits: List<String>.from(json["benefits"]),
        howToStart: List<String>.from(json["howToStart"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );
}

// ---------------- WEEKLY PROGRESS -----------------

class WeeklyProgress {
  final String date;
  final int duration;

  WeeklyProgress({
    required this.date,
    required this.duration,
  });

  factory WeeklyProgress.fromJson(Map<String, dynamic> json) =>
      WeeklyProgress(
        date: json["date"],
        duration: json["duration"],
      );
}

// ---------------- SUMMARY -----------------

class Summary {
  final SummaryStats today;
  final SummaryStats last7Days;
  final SummaryStats last30Days;
  final Overall overall;

  Summary({
    required this.today,
    required this.last7Days,
    required this.last30Days,
    required this.overall,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    today: SummaryStats.fromJson(json["today"]),
    last7Days: SummaryStats.fromJson(json["last7Days"]),
    last30Days: SummaryStats.fromJson(json["last30Days"]),
    overall: Overall.fromJson(json["overall"]),
  );
}

class SummaryStats {
  final int activitiesCount;
  final int completedCount;
  final int totalDuration;

  SummaryStats({
    required this.activitiesCount,
    required this.completedCount,
    required this.totalDuration,
  });

  factory SummaryStats.fromJson(Map<String, dynamic> json) => SummaryStats(
    activitiesCount: json["activitiesCount"],
    completedCount: json["completedCount"],
    totalDuration: json["totalDuration"],
  );
}

// ---------------- OVERALL -----------------

class Overall {
  final int totalActivities;
  final int completedActivities;
  final int totalDurationMinutes;
  final int totalDurationHours;
  final int screenFreeTimeMinutes;
  final int screenFreeTimeHours;
  final String screenFreeTimeFormatted;
  final int activitiesByCategory;

  Overall({
    required this.totalActivities,
    required this.completedActivities,
    required this.totalDurationMinutes,
    required this.totalDurationHours,
    required this.screenFreeTimeMinutes,
    required this.screenFreeTimeHours,
    required this.screenFreeTimeFormatted,
    required this.activitiesByCategory,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    totalActivities: json["totalActivities"],
    completedActivities: json["completedActivities"],
    totalDurationMinutes: json["totalDurationMinutes"],
    totalDurationHours: json["totalDurationHours"],
    screenFreeTimeMinutes: json["screenFreeTimeMinutes"],
    screenFreeTimeHours: json["screenFreeTimeHours"],
    screenFreeTimeFormatted: json["screenFreeTimeFormatted"],
    activitiesByCategory: json["activitiesByCategory"],
  );
}

// ---------------- CATEGORY BREAKDOWN (EMPTY LIST CURRENTLY) -----------------

class CategoryBreakdown {
  CategoryBreakdown();

  factory CategoryBreakdown.fromJson(Map<String, dynamic> json) =>
      CategoryBreakdown();
}

// ---------------- STREAKS -----------------

class Streaks {
  final int current;
  final int longest;

  Streaks({
    required this.current,
    required this.longest,
  });

  factory Streaks.fromJson(Map<String, dynamic> json) => Streaks(
    current: json["current"],
    longest: json["longest"],
  );
}
