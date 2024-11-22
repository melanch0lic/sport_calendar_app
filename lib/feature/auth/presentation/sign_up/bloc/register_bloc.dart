import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_calendart_app/feature/auth/domain/entity/models/user.dart';
import 'package:sport_calendart_app/feature/auth/domain/repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<RegisterEvent>(_onSignUp);
  }

  Future<void> _onSignUp(RegisterEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    try {
      // Регистрация
      final user = await authRepository.signUp(event.login, event.password);

      // Сохранение пользователя локально
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));

      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure("Ошибка регистрации: ${e.toString()}"));
    }
  }
}
