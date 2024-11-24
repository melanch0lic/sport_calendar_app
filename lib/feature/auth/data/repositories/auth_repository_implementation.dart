import '../../../../core/modules/auth/token_storage.dart';
import '../../logic/auth_interceptor.dart';
import '../datasources/auth_datasource.dart';

/// AuthRepository
abstract interface class AuthRepository<T> implements AuthStatusSource {
  Future<T> checkEmailCode(String code);

  /// Sign in with email and password
  Future<T> signInWithEmailAndPassword(String email, String password);

  /// Sign up with email and password
  Future<void> signUp(String email, String password);

  /// Sign out
  Future<void> signOut();
}

/// AuthRepositoryImpl
final class AuthRepositoryImpl<T> implements AuthRepository<T> {
  final AuthDataSource<T> _dataSource;
  final TokenStorage<T> _storage;

  /// Create an [AuthRepositoryImpl]
  const AuthRepositoryImpl({
    required AuthDataSource<T> dataSource,
    required TokenStorage<T> storage,
  })  : _dataSource = dataSource,
        _storage = storage;

  @override
  Future<T> checkEmailCode(String code) async {
    try {
      final token = await _dataSource.checkEmailCode(code);
      await _storage.save(token);
      return token;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<T> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final token = await _dataSource.signInWithEmailAndPassword(email, password);
      await _storage.save(token);
      return token;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await _dataSource.signUp(email, password);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    // await _dataSource.signOut();
    await _storage.clear();
  }

  @override
  Stream<AuthenticationStatus> get authStatus => _storage.getStream().map(
        (token) => token != null ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated,
      );
}
