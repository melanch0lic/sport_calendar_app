import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';

abstract interface class EventRepository {
  Future<List<EventData>> fetchEvents({
    String? discipline,
    String? sport,
    String? location,
    int? participants,
    String? gender,
    int? ageMin,
    String? competitionType,
    String? dateFrom,
    String? dateTo,
  });
}
