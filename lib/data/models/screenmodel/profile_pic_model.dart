class ProfilePicModel {
  final String profilePic;

  ProfilePicModel({required this.profilePic});

  factory ProfilePicModel.fromJson(Map<String, dynamic> json) {
    return ProfilePicModel(
      profilePic: json['profile_pic'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_pic': profilePic,
    };
  }
}
