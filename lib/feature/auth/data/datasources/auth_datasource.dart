import 'package:dio/dio.dart';

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
      final token = await _authApi.checkEmailCode({'code': code});
      return Token(token.accessToken, token.refreshToken);
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
      await _authApi.signInWithEmailAndPassword({'email': email, 'password': password});
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
      await _authApi.signUp({'email': email, 'password': password});
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