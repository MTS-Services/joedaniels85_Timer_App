class SendMailModel {
  final String email;

  const SendMailModel({
    required this.email,
  });

  SendMailModel copyWith({
    String? email,
  }) {
    return SendMailModel(
      email: email ?? this.email,
    );
  }

  factory SendMailModel.fromJson(Map<String, dynamic> json) {
    return SendMailModel(
      email: json['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  @override
  String toString() => 'UserEmailModel(email: $email)';
}
