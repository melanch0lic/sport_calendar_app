import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/modules/auth/token_storage.dart';
import '../../../../core/utils/preferences_dao.dart';
import '../../logic/auth_interceptor.dart';
import '../../logic/fake_http_client.dart';

final class TokenStorageSP implements TokenStorage<Token> {
  TokenStorageSP({required SharedPreferences sharedPreferences})
      : _accessToken = TypedEntry(
          sharedPreferences: sharedPreferences,
          key: 'authorization.access_token',
        ),
        _refreshToken = TypedEntry(
          sharedPreferences: sharedPreferences,
          key: 'authorization.refresh_token',
        );

  late final PreferencesEntry<String> _accessToken;
  late final PreferencesEntry<String> _refreshToken;
  final _streamController = StreamController<Token?>.broadcast();

  @override
  Future<Token?> load() async {
    final accessToken = _accessToken.read();
    final refreshToken = _refreshToken.read();

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return Token(accessToken, refreshToken);
  }

  @override
  Future<bool> hasToken() async => _accessToken.read() != null;

  @override
  Future<void> save(Token tokenPair) async {
    await (_accessToken.set(tokenPair.accessToken), _refreshToken.set(tokenPair.refreshToken)).wait;

    ShowcaseHelper().clear();

    _streamController.add(tokenPair);
  }

  @override
  Future<void> clear() async {
    await (_accessToken.remove(), _refreshToken.remove()).wait;
    ShowcaseHelper().clear();
    _streamController.add(null);
  }

  @override
  Stream<Token?> getStream() => _streamController.stream;

  @override
  Future<void> close() => _streamController.close();
}
