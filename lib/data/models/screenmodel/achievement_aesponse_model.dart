class AchievementResponse {
  final bool success;
  final AchievementData data;
  final String message;

  AchievementResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AchievementResponse.fromJson(Map<String, dynamic> json) {
    return AchievementResponse(
      success: json['success'],
      data: AchievementData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class AchievementData {
  final List<Achievement> unlockedAchievements;
  final List<Achievement> nextAchievements;
  final int totalUnlocked;
  final int currentStreak;
  final Summary summary;

  AchievementData({
    required this.unlockedAchievements,
    required this.nextAchievements,
    required this.totalUnlocked,
    required this.currentStreak,
    required this.summary,
  });

  factory AchievementData.fromJson(Map<String, dynamic> json) {
    return AchievementData(
      unlockedAchievements: (json['unlockedAchievements'] as List)
          .map((e) => Achievement.fromJson(e))
          .toList(),
      nextAchievements: (json['nextAchievements'] as List)
          .map((e) => Achievement.fromJson(e))
          .toList(),
      totalUnlocked: json['totalUnlocked'],
      currentStreak: json['currentStreak'],
      summary: Summary.fromJson(json['summary']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unlockedAchievements':
      unlockedAchievements.map((e) => e.toJson()).toList(),
      'nextAchievements': nextAchievements.map((e) => e.toJson()).toList(),
      'totalUnlocked': totalUnlocked,
      'currentStreak': currentStreak,
      'summary': summary.toJson(),
    };
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String badge;
  final String type;
  final int progress;
  final int target;
  final bool completed;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.badge,
    required this.type,
    required this.progress,
    required this.target,
    required this.completed,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      badge: json['badge'],
      type: json['type'],
      progress: json['progress'],
      target: json['target'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'badge': badge,
      'type': type,
      'progress': progress,
      'target': target,
      'completed': completed,
    };
  }
}

class Summary {
  final int totalActivities;
  final int completedActivities;
  final int totalHours;
  final int currentStreak;

  Summary({
    required this.totalActivities,
    required this.completedActivities,
    required this.totalHours,
    required this.currentStreak,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalActivities: json['totalActivities'],
      completedActivities: json['completedActivities'],
      totalHours: json['totalHours'],
      currentStreak: json['currentStreak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalActivities': totalActivities,
      'completedActivities': completedActivities,
      'totalHours': totalHours,
      'currentStreak': currentStreak,
    };
  }
}
