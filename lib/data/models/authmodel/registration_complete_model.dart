class RegistrationCompleteModel {
  final String code;

  RegistrationCompleteModel({
    required this.code,
  });

  factory RegistrationCompleteModel.fromJson(Map<String, dynamic> json) {
    return RegistrationCompleteModel(
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }

  @override
  String toString() {
    return 'RegistrationCompleteModel(code: $code)';
  }
}
