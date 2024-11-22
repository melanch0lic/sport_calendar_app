part of '../app_router.dart';

final _profileRoutes = [
  GoRoute(
    path: ProfileRoutes.profile.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
