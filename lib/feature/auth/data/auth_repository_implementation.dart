import 'package:dio/dio.dart';

import 'package:sport_calendart_app/feature/auth/domain/entity/models/user.dart';
import 'package:sport_calendart_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final Dio dio;
  AuthRepositoryImplementation({required this.dio});

  @override
  Future<void> signIn(Pattern login, String password) async {
    final response = await signIn(login, password);
  }

  @override
  Future<User> signUp(String login, String password) async {
    final response = await signUp(login, password);
    return User(login: '', passsword: '', token: '');
  }

  @override
  Future<void> logOut() async {}
}
