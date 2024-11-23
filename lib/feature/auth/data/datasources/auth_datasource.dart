import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sport_calendart_app/feature/auth/domain/entity/auth_login_request.dart';

import '../../domain/code_model.dart';
import '../../domain/entity/auth_request.dart';
import '../../logic/auth_interceptor.dart';
import '../auth_api.dart';

/// Data source for authentication
abstract interface class AuthDataSource<T> {
  Future<T> checkEmailCode(String code);

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password);

  /// Sign up with email and password
  Future<void> signUp(String email, String password);

  /// Sign out
  Future<void> signOut();
}

/// Auth data source that interacts with backend
/// and interprets the response as [Token] or throws [AuthenticationException]
final class AuthDataSourceNetwork implements AuthDataSource<Token> {
  final AuthApi _authApi;

  /// Create an [AuthDataSourceNetwork]
  AuthDataSourceNetwork(AuthApi authApi) : _authApi = authApi;

  @override
  Future<Token> checkEmailCode(String code) async {
    try {
      final response = await _authApi.checkEmailCode(CodeModel(code: code));
      return Token(response.data!.accessToken, response.data!.refreshToken);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
        throw const WrongCredentialsException();
      }

      throw UnknownAuthenticationException(error: error);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _authApi.signInWithEmailAndPassword(AuthLoginRequest(login: email, password: password));
    } on DioException catch (error) {
      if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
        throw const WrongCredentialsException();
      }

      throw UnknownAuthenticationException(error: error);
    } catch (error) {
      throw UnknownAuthenticationException(error: error);
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      final token = await FirebaseMessaging.instance.getToken() ?? 'None';
      await _authApi.signUp(
        AuthRequest(email: email, password: password, deviceToken: token
            // +
            // Random().nextInt(100).toString()
            ),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
        throw const WrongCredentialsException();
      }

      throw UnknownAuthenticationException(error: error);
    } catch (error) {
      throw UnknownAuthenticationException(error: error);
    }
  }

  @override
  Future<void> signOut() async {}
}

/// Exception thrown when the authentication fails
base class AuthenticationException implements Exception {
  /// Create a [AuthenticationException]
  const AuthenticationException();
}

/// Exception thrown when the credentials are wrong
final class WrongCredentialsException implements AuthenticationException {
  /// Create a [WrongCredentialsException]
  const WrongCredentialsException();

  /// [10001] is the system error code for wrong credentials
  static const int code = 10001;
}

/// Unknown authentication exception
final class UnknownAuthenticationException implements AuthenticationException {
  /// System error code, that is not understood
  final int? code;

  /// Error message
  final Object error;

  /// Create a [UnknownAuthenticationException]
  const UnknownAuthenticationException({
    required this.error,
    this.code,
  });
}
