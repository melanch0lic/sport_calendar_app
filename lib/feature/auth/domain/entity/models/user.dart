import 'dart:convert';

class User {
  final String login;
  final String passsword;
  final String token;

  User({
    required this.login,
    required this.passsword,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      passsword: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': passsword,
      'token': token,
    };
  }
}
