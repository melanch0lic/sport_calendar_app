import 'package:sport_calendart_app/feature/auth/domain/entity/models/user.dart';
import 'package:sport_calendart_app/feature/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<void> signIn(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Симуляция запроса
    if (login != "test_user" || password != "123456") {
      throw Exception("Неверный логин или пароль");
    }
  }

  Future<User> signUp(String login, String password) async {
    // Симуляция запроса
    await Future.delayed(const Duration(seconds: 2));
    if (login.isNotEmpty && password.isNotEmpty) {
      return User(
        login: login,
        passsword: password,
        token: "mocked_token_12345",
      );
    } else {
      throw Exception("Неверные данные");
    }
  }

  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Симуляция запроса
  }
}
