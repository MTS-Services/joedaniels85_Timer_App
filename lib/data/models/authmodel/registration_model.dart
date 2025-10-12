class RegistrationModel {
  String name;
  String email;
  String password;

  RegistrationModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  String get getName => name;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'RegistrationModel(name: $name, email: $email, password: $password)';
  }
}
