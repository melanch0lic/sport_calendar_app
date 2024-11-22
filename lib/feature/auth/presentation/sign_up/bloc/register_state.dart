part of 'register_bloc.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegistrationState {}

class RegisterLoading extends RegistrationState {}

class RegisterSuccess extends RegistrationState {
  final User user;

  RegisterSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class RegisterFailure extends RegistrationState {
  final String error;

  RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}
