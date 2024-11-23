sealed class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password,
  });
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({
    required this.email,
    required this.password,
  });
}

class OtpVerificationRequested extends AuthEvent {
  final String otpCode;

  OtpVerificationRequested({required this.otpCode});
}

class SignOutRequested extends AuthEvent {}
