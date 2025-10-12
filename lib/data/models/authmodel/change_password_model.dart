class ChangePasswordModel {
  final String newPassword;

  ChangePasswordModel({required this.newPassword});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      newPassword: json['newPassword'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'newPassword': newPassword,
    };
  }
}
