import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_calendart_app/core/utils/extension/src/context_extension.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_event.dart';

import '../../../runner/dependency_scope.dart';
import '../data/bloc/bloc/auth_bloc.dart';
import '../data/bloc/bloc/auth_state.dart';
import '../logic/auth_interceptor.dart';

/// Auth controller
abstract interface class AuthController {
  /// Authentication status
  AuthenticationStatus get status;

  void signInWithEmailAndPassword(String email, String password);

  void signUp(String email, String password);

  void checkEmailCode(String code);

  void signOut();
}

/// Scope that controls the authentication state
class AuthScope extends StatefulWidget {
  /// Create an [AuthScope]
  const AuthScope({required this.child, super.key});

  /// The child widget
  final Widget child;

  /// Get the [AuthController] from the [BuildContext]
  static AuthController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_AuthInherited>(listen: listen).controller;

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

class _AuthScopeState extends State<AuthScope> implements AuthController {
  late final AuthBloc _authBloc;
  late AuthState _state;

  @override
  void initState() {
    super.initState();
    _authBloc = DependenciesScope.of(context).resolve<AuthBloc>();
    _state = _authBloc.state;
  }

  @override
  AuthenticationStatus get status =>
      _state is AuthAuthenticated ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated;

  @override
  void signInWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _authBloc.add(
        SignInRequested(
          email: email,
          password: password,
        ),
      );

  @override
  void signUp(String email, String password) => _authBloc.add(
        SignUpRequested(
          email: email,
          password: password,
        ),
      );

  @override
  void checkEmailCode(String code) => _authBloc.add(OtpVerificationRequested(otpCode: code));

  @override
  void signOut() => _authBloc.add(SignOutRequested());

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          _state = state;

          return _AuthInherited(
            controller: this,
            state: _authBloc.state,
            child: widget.child,
          );
        },
      );
}

final class _AuthInherited extends InheritedWidget {
  final AuthController controller;
  final AuthState state;

  const _AuthInherited({
    required super.child,
    required this.controller,
    required this.state,
  });

  @override
  bool updateShouldNotify(covariant _AuthInherited oldWidget) => state != oldWidget.state;
}
