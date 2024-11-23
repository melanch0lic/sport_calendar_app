class Event {
  final String sport;
  final String discipline;
  final String location;
  final int participants;
  final String gender;
  final int? eventAgeMin;
  final int? eventAgeMax;
  final String competitionType;
  final String period;
  final String eventStartAt;
  final String eventEndAt;

  Event({
    required this.sport,
    required this.discipline,
    required this.location,
    required this.participants,
    required this.gender,
    required this.eventAgeMin,
    required this.eventAgeMax,
    required this.competitionType,
    required this.period,
    required this.eventStartAt,
    required this.eventEndAt,
  });
}
