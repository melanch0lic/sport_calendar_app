import 'package:sport_calendart_app/feature/home/domain/entity/models/event.dart';

abstract interface class EventRepository {
  Future<List<Event>> fetchEvents();
}
