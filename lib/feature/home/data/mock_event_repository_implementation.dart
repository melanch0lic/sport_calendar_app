import 'package:sport_calendart_app/feature/home/domain/entity/models/event.dart';
import 'package:sport_calendart_app/feature/home/domain/repositories/event_repository.dart';

class MockEventRepositoryImplementation implements EventRepository {
  // MockEventRepositoryImplementation();

  @override
  Future<List<Event>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      5,
      (index) => Event(
        location: 'Москва',
        competitionType: "Событие ${index + 1}",
        gender: index % 2 == 0 ? "M" : "F",
        eventAgeMin: 18,
        eventAgeMax: 35,
        sport: "Sport-${index + 1}",
        participants: 100 - index * 10,
        eventStartAt: DateTime.now().toIso8601String(),
        eventEndAt: DateTime.now().add(const Duration(hours: 3)).toIso8601String(),
        discipline: '',
        period: '',
      ),
    );
  }
}
