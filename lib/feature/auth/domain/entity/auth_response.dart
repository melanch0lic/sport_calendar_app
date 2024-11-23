import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String status;
  final AuthTokenData? data; // Поле для успешного ответа
  final ErrorResponse? error; // Поле для ошибки

  AuthResponse({
    required this.status,
    this.data,
    this.error,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class AuthTokenData {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'access_token_expires_at')
  final String accessTokenExpiresAt;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'refresh_token_expires_at')
  final String refreshTokenExpiresAt;

  AuthTokenData({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
  });

  factory AuthTokenData.fromJson(Map<String, dynamic> json) => _$AuthTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenDataToJson(this);
}

@JsonSerializable()
class ErrorResponse {
  final int code;
  final String message;

  ErrorResponse({
    required this.code,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
