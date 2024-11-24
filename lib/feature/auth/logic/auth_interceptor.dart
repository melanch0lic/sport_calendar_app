import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sport_calendart_app/feature/auth/data/auth_api.dart';

import '../../../core/modules/auth/token_storage.dart';

/// Token is a simple class that holds the access and refresh token

class Token {
  /// Create a [Token]
  const Token(this.accessToken, this.refreshToken);

  /// Access token (used to authenticate the user)
  final String accessToken;

  /// Refresh token (used to refresh the access token)
  final String refreshToken;
}

/// Status of the authentication
enum AuthenticationStatus {
  /// Authenticated
  authenticated,

  /// Unauthenticated
  unauthenticated,
}

/// AuthStatusSource is used to get the status of the authentication
abstract interface class AuthStatusSource {
  /// Stream of [AuthenticationStatus]
  Stream<AuthenticationStatus> get authStatus;
}

class TokenInterceptor extends Interceptor {
  final AuthApi authApi;
  final TokenStorage<Token> sessionData;

  const TokenInterceptor({required this.sessionData, required this.authApi});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sessionData.load();
    if (token != null && !options.uri.path.contains('refresh')) {
      // final decodedToken = JwtDecoder.decode(token.accessToken);
      // if (DateTime.now().unixtime < decodedToken['exp']) {
      //   options.headers.addAll({'Authorization': 'Bearer $token'});
      // } else {
      //   print('Refreshing token...');
      //   //TODO refresh token
      //   // final newtoken = sessionData.getAccessToken();
      //   // options.headers.addAll({'Authorization': 'Bearer $newtoken'});
      // }
      options.headers.addAll({'Authorization': 'Bearer ${token.accessToken}'});
    }
    super.onRequest(options, handler);
  }
}
