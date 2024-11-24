part of '../app_router.dart';

final _homeRoutes = [
  GoRoute(
    path: HomeRoutes.home.path,
    builder: (_, state) => HomePage(key: state.pageKey),
  ),
  GoRoute(
    path: HomeRoutes.detail.path,
    builder: (_, state) => DetailPage(key: state.pageKey, event: state.extra as EventData),
  ),
  GoRoute(
    path: HomeRoutes.notifications.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
