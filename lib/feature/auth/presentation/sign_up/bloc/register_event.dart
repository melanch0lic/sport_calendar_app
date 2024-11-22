part of 'register_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends RegistrationEvent {
  final String login;
  final String password;

  RegisterEvent({required this.login, required this.password});
  @override
  List<Object?> get props => [login, password];
}
