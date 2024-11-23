import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';

/// {@template fake_http_client}
/// A fake HTTP client, that returns mock responses.
///
/// This is used in the application instead of communicating with a real server.
/// {@endtemplate}
class FakeHttpClient extends MockClient {
  /// {@macro fake_http_client}
  FakeHttpClient() : super(_handler);

  static Future<Response> _handler(Request request) async {
    final helper = ShowcaseHelper();

    if (request.url.path == '/login') {
      return Response(
        '{"access_token": "abcd", "refresh_token": "abcd"}',
        200,
        request: request,
      );
    }

    if (request.url.path == '/refresh') {
      await Future<void>.delayed(const Duration(seconds: 1));
      // if the refresh token is expired, return 401
      if (helper.expireRefresh) {
        return Response(
          'Unauthorized',
          401,
          request: request,
        );
      }

      return Response(
        '{"access_token": "abcd", "refresh_token": "abcd"}',
        200,
        request: request,
      );
    }

    if (helper.expireAccess || helper.expireRefresh) {
      await Future<void>.delayed(const Duration(seconds: 1));
      return Response(
        'Unauthorized',
        401,
        request: request,
      );
    }

    if (request.url.path == '/pokemons') {
      await Future<void>.delayed(const Duration(seconds: 2));
      return Response(
        json.encode([
          {'name': 'Pikachu', 'type': 'Electric'},
          {'name': 'Charmander', 'type': 'Fire'},
          {'name': 'Squirtle', 'type': 'Water'},
        ]),
        200,
        request: request,
      );
    }

    return Response('Not Found', 404, request: request);
  }
}

/// {@template token_expirer_helper}
/// Singleton that is used to simulate the token expiration
///
/// This class is used to simulate the token expiration in the example
/// and can't be used in a real-world application.
///
/// The token expiration is simulated by setting
/// the [expireAccess] and [expireRefresh] variables to `true` and
/// then to `false` after corresponding actions are taken.
/// {@endtemplate}
class ShowcaseHelper {
  /// {@macro token_expirer_helper}
  factory ShowcaseHelper() => _instance;

  ShowcaseHelper._();

  final _controller = StreamController<void>.broadcast();

  static final ShowcaseHelper _instance = ShowcaseHelper._();

  bool _expireAccess = false;

  /// This variable controls the expiration of the access token.
  ///
  /// If it is expired, then on the next request to the server, the server will
  /// return a 401 status code, which will force the client to refresh token.
  bool get expireAccess => _expireAccess;
  set expireAccess(bool value) {
    _expireAccess = value;

    _controller.add(null);
  }

  bool _expireRefresh = false;

  /// This variable controls the expiration of the refresh token.
  ///
  /// If it is expired, then on the next request to the server, the server will
  /// return a 401 status code, which will force the client to log in again.
  bool get expireRefresh => _expireRefresh;
  set expireRefresh(bool value) {
    _expireRefresh = value;

    _controller.add(null);
  }

  /// Stream that emits an event when the [expireAccess] or [expireRefresh]
  /// variables are changed.
  Stream<void> get stream => _controller.stream;

  /// Resets the [expireAccess] and [expireRefresh] variables to `false`.
  void clear() {
    expireAccess = false;
    expireRefresh = false;

    _controller.add(null);
  }
}
