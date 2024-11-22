class HomeState {
  final List<Event> events;
  final String searchQuery;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.events = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.errorMessage,
  });

  const HomeState.initial() : this();

  HomeState copyWith({
    List<Event>? events,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      events: events ?? this.events,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeState &&
        other.events == events &&
        other.searchQuery == searchQuery &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(events, searchQuery, isLoading, errorMessage);

  @override
  String toString() {
    return 'HomeState(events: $events, searchQuery: $searchQuery, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

class Event {
  final String id;
  final String name;
  final DateTime date;

  Event({required this.id, required this.name, required this.date});
}
