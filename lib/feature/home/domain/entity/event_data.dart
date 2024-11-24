import 'package:json_annotation/json_annotation.dart';

part 'event_data.g.dart';

@JsonSerializable()
class EventData {
  @JsonKey(name: 'event_id')
  final int eventId;

  @JsonKey(name: 'parent_event_id')
  final int? parentEventId;

  @JsonKey(name: 'sport_type_id')
  final String sportTypeId;

  @JsonKey(name: 'team_type_id')
  final String teamTypeId;

  @JsonKey(name: 'event_location')
  final String eventLocation;

  @JsonKey(name: 'event_ekp_number')
  final String eventEkpNumber;

  @JsonKey(name: 'event_name')
  final String eventName;

  @JsonKey(name: 'event_gender')
  final String eventGender;

  @JsonKey(name: 'event_age_min')
  final int eventAgeMin;

  @JsonKey(name: 'event_age_max')
  final int eventAgeMax;

  @JsonKey(name: 'event_participants')
  final int eventParticipants;

  @JsonKey(name: 'disciplines_data')
  final List<String> disciplinesData;

  @JsonKey(name: 'event_start_date')
  final DateTime eventStartDate;

  @JsonKey(name: 'event_end_date')
  final DateTime eventEndDate;

  @JsonKey(name: 'event_created_at')
  final DateTime eventCreatedAt;

  @JsonKey(name: 'event_updated_at')
  final DateTime eventUpdatedAt;

  EventData({
    required this.eventId,
    this.parentEventId,
    required this.sportTypeId,
    required this.teamTypeId,
    required this.eventLocation,
    required this.eventEkpNumber,
    required this.eventName,
    required this.eventGender,
    required this.eventAgeMin,
    required this.eventAgeMax,
    required this.eventParticipants,
    required this.disciplinesData,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventCreatedAt,
    required this.eventUpdatedAt,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => _$EventDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventDataToJson(this);
}
