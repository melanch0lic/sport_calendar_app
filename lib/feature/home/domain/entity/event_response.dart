import 'package:json_annotation/json_annotation.dart';
import 'package:sport_calendart_app/core/error/api_error/error_response.dart';

import 'event_data.dart';

part 'event_response.g.dart';

@JsonSerializable()
class EventResponse {
  final String status;
  final List<EventData>? data;
  final ErrorResponse? error;

  EventResponse({
    required this.status,
    required this.data,
    required this.error,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) => _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}
