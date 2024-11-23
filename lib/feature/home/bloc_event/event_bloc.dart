import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_calendart_app/feature/home/data/mock_event_repository_implementation.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/models/event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final MockEventRepositoryImplementation repository;

  EventBloc(this.repository) : super(EventInitial()) {
    on<LoadEvents>((event, emit) async {
      emit(EventLoading());
      try {
        final events = await repository.fetchEvents();
        emit(EventLoaded(events));
      } catch (e) {
        emit(EventError("Не удалось загрузить события"));
      }
    });
  }
}
