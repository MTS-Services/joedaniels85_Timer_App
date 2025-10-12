class UserProfile {
  final bool success;
  final UserData data;
  final String message;

  UserProfile({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      success: json['success'],
      data: UserData.fromJson(json['data']),
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

class UserData {
  final String id;
  final String name;
  final String email;
  final String? profilePic;
  final String provider;
  final DateTime lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Stats stats;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.profilePic,
    required this.provider,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.stats,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePic: json['profile_pic'],
      provider: json['provider'],
      lastLogin: DateTime.parse(json['lastLogin']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      stats: Stats.fromJson(json['stats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
      'provider': provider,
      'lastLogin': lastLogin.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'stats': stats.toJson(),
    };
  }
}

class Stats {
  final int totalActivities;
  final int completedActivities;
  final int daysSinceMember;
  final String memberSince;

  Stats({
    required this.totalActivities,
    required this.completedActivities,
    required this.daysSinceMember,
    required this.memberSince,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalActivities: json['totalActivities'],
      completedActivities: json['completedActivities'],
      daysSinceMember: json['daysSinceMember'],
      memberSince: json['memberSince'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalActivities': totalActivities,
      'completedActivities': completedActivities,
      'daysSinceMember': daysSinceMember,
      'memberSince': memberSince,
    };
  }
}
