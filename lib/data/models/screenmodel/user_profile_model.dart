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
  String? uid;
  String role;
  DateTime lastLogin;
  DateTime createdAt;
  DateTime updatedAt;
  Map<String, dynamic>? count; // From _count field

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.profilePic,
    this.uid,
    required this.role,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    this.count,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      name: json['name'] ?? 'User Name', // Provide default value
      email: json['email'] ?? '',
      profilePic: json['profile_pic'],
      uid: json['uid'],
      role: json['role'] ?? 'USER',
      lastLogin: DateTime.parse(json['lastLogin'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      count: json['_count'] is Map ? Map<String, dynamic>.from(json['_count']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
      'uid': uid,
      'role': role,
      'lastLogin': lastLogin.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '_count': count,
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
