import '../../logic/auth_interceptor.dart';
import 'auth_datasource.dart';

class MockAuthDataSource implements AuthDataSource<Token> {
  final Map<String, String> _mockDatabase = {
    "kudza76@mail.ru": "123456",
  };
  String? _currentUser;
  final String _mockToken = "mockAccessToken";
  final String _mockRefreshToken = "mockRefreshToken";

  @override
  Future<Token> checkEmailCode(String code) async {
    // Simulate email code validation
    if (code == "123456") {
      return Future.value(Token(_mockToken, _mockRefreshToken));
    }
    throw Exception("Invalid email code");
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    print(email);
    print(password);
    print(_mockDatabase[email]);
    // Simulate signing in with email and password
    if (_mockDatabase[email] == password) {
      await Future.delayed(const Duration(seconds: 1));
      print("Go to OTP page");
    } else {
      throw Exception("Invalid email or password");
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    // Simulate user sign-up
    if (_mockDatabase.containsKey(email)) {
      throw Exception("Email already exists");
    }
    _mockDatabase[email] = password;
  }

  @override
  Future<void> signOut() async {
    // Simulate signing out
    if (_currentUser == null) {
      throw Exception("No user is signed in");
    }
    _currentUser = null;
  }
}
