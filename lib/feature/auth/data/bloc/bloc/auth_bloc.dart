import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository_implementation.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case SignInRequested():
          await _onSignInRequested(event, emit);
        case SignUpRequested():
          await _onSignUpRequested(event, emit);
        case OtpVerificationRequested():
          await _onOtpVerificationRequested(event, emit);
        case SignOutRequested():
          await _onSignOutRequested(event, emit);
      }
    });
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await authRepository.signInWithEmailAndPassword(event.email, event.password);
      emit(AuthAuthenticated(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      ));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signUp(event.email, event.password);
      emit(AuthOtpSent());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onOtpVerificationRequested(OtpVerificationRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await authRepository.checkEmailCode(event.otpCode);
      emit(AuthAuthenticated(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      ));
    } catch (e) {
      emit(AuthOtpSentError());
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
