import 'package:json_annotation/json_annotation.dart';

part 'auth_login_request.g.dart';

@JsonSerializable()
class AuthLoginRequest {
  final String login;
  final String password;

  AuthLoginRequest({
    required this.login,
    required this.password,
  });

  /// Конвертирует объект в JSON
  Map<String, dynamic> toJson() => _$AuthLoginRequestToJson(this);

  /// Генерирует объект из JSON (если нужно)
  factory AuthLoginRequest.fromJson(Map<String, dynamic> json) => _$AuthLoginRequestFromJson(json);
}
