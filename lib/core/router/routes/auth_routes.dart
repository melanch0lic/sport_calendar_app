part of '../app_router.dart';

final _authRoutes = [
  GoRoute(
    path: AuthRoutes.signIn.path,
    builder: (_, state) => SignInPage(key: state.pageKey),
  ),
  GoRoute(
    path: AuthRoutes.signUp.path,
    builder: (_, state) => SignUpPage(key: state.pageKey),
  ),
  GoRoute(
    path: AuthRoutes.otp.path,
    builder: (_, state) => OtpPage(key: state.pageKey),
  ),
];
