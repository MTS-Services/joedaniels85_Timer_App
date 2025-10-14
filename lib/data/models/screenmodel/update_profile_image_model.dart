class UpdateProfileModel {
  String name;
  String email;
  String? profilePic;

  UpdateProfileModel({
    required this.name,
    required this.email,
    this.profilePic,
  });

  // -------------------- fromJson --------------------
  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePic: json['profile_pic']?.toString().replaceAll("'", ""),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile_pic': profilePic,
    };
  }


  @override
  String toString() {
    return 'UserData(name: $name, email: $email, profilePic: $profilePic)';
  }
}
