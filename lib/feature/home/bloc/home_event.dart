sealed class HomeEvent {}

/// Event to trigger a search
class SearchEvent extends HomeEvent {
  final String query;

  SearchEvent(this.query);

  @override
  String toString() => 'SearchEvent(query: $query)';
}

/// Event to load all events with optional filters
class LoadEventsEvent extends HomeEvent {
  final Map<String, dynamic>? filters;

  LoadEventsEvent({this.filters});

  @override
  String toString() => 'LoadEventsEvent(filters: $filters)';
}

/// Event to handle refresh (e.g., pull-to-refresh)
class RefreshEventsEvent extends HomeEvent {
  @override
  String toString() => 'RefreshEventsEvent';
}

/// Event to handle error acknowledgement (e.g., dismiss an error message)
class AcknowledgeErrorEvent extends HomeEvent {
  @override
  String toString() => 'AcknowledgeErrorEvent';
}
