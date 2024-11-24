import 'package:dio/dio.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/domain/repositories/event_repository.dart';

class EventRepositoryNetwork implements EventRepository {
  final Dio _dio;

  EventRepositoryNetwork(this._dio);

  @override
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
  }) async {
    final Map<String, dynamic> queryParams = {
      if (discipline != null) 'discipline': discipline,
      if (sport != null) 'sport': sport,
      if (location != null) 'location': location,
      if (participants != null) 'participants': participants,
      if (gender != null) 'gender': gender,
      if (ageMin != null) 'age_min': ageMin,
      if (competitionType != null) 'comptetition_type': competitionType,
      if (dateFrom != null) 'date_from': dateFrom,
      if (dateTo != null) 'date_to': dateTo,
    };

    try {
      final response = await _dio.get('/api/events', queryParameters: queryParams);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] as List;

        return data.map((eventJson) => EventData.fromJson(eventJson)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } on DioException catch (error) {
      throw Exception('Network error: ${error.message}');
    }
  }
}
