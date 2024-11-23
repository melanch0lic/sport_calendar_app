import 'package:json_annotation/json_annotation.dart';

part 'fcm_token_update.g.dart';

@JsonSerializable()
class FcmTokenUpdate {
  final String oldToken;
  final String newToken;

  FcmTokenUpdate({
    required this.oldToken,
    required this.newToken,
  });

  Map<String, dynamic> toJson() => _$FcmTokenUpdateToJson(this);
}
