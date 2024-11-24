import 'package:sport_calendart_app/feature/home/domain/repositories/event_repository.dart';

import '../../domain/entity/event_data.dart';

class MockEventRepositoryImplementation implements EventRepository {
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
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      5,
      (index) => EventData(
        eventId: index + 1,
        parentEventId: null,
        sportTypeId: 'Sport-${index + 1}',
        teamTypeId: 'Team-${index + 1}',
        eventLocation: 'Москва',
        eventEkpNumber: "'0'",
        eventName: "Событие ${index + 1}",
        eventGender: index % 2 == 0 ? "M" : "F",
        eventAgeMin: 18,
        eventAgeMax: 35,
        eventParticipants: 100 - index * 10,
        disciplinesData: ["Discipline ${index + 1}"],
        eventStartDate: DateTime.now(),
        eventEndDate: DateTime.now(),
        eventCreatedAt: DateTime.now(),
        eventUpdatedAt: DateTime.now(),
      ),
    );
  }
}
