part of '../app_router.dart';

final _calendarRoutes = [
  GoRoute(
    path: CalendarRoutes.calendar.path,
    builder: (_, state) => CalendarPage(key: state.pageKey),
  ),
];
