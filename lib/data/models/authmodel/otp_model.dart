
class OtpModel {
  final String code;

  OtpModel({required this.code});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      code: json['code'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}