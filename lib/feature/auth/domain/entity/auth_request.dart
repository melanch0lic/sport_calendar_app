import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  final String email;
  final String password;

  @JsonKey(name: 'device_token')
  final String deviceToken;

  AuthRequest({
    required this.email,
    required this.password,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);

  factory AuthRequest.fromJson(Map<String, dynamic> json) => _$AuthRequestFromJson(json);
}
