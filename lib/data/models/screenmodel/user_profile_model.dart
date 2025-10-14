class UserProfileModel {
  bool success;
  UserData data;
  String message;

  UserProfileModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
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
  String id;
  String name;
  String email;
  String? profilePic;
  String provider;
  DateTime lastLogin;
  DateTime createdAt;
  DateTime updatedAt;
  Stats stats;

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
  int totalActivities;
  int completedActivities;
  int daysSinceMember;
  String memberSince;

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
