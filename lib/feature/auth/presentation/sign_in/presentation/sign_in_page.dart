import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_bloc.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

import '../../../../../core/router/routes_enum.dart';
import '../../../../../core/utils/text_field_outline_border.dart';
import '../../../data/bloc/bloc/auth_state.dart';
import '../../auth_scope.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Авторизация',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    controller: _emailController,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: TextFieldOutlineBorder(
                        scheme: theme.colorScheme,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _PasswordTextField(controller: _passwordController),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 48,
                  child: BlocListener<AuthBloc, AuthState>(
                    bloc: DependenciesScope.of(context).resolve<AuthBloc>(),
                    listener: (context, state) {
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                      if (state is AuthOtpSent) {
                        context.push(AuthRoutes.otp.path);
                      }
                    },
                    child: FilledButton(
                      style: theme.elevatedButtonTheme.style,
                      onPressed: () {
                        // Adds the [AuthEvent.signInWithEmailAndPassword]
                        // event to the [AuthBloc]
                        AuthScope.of(context).signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: Text(
                        'Sign in',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FilledButton(
                  style: theme.elevatedButtonTheme.style,
                  onPressed: () {
                    context.push(AuthRoutes.signUp.path);
                  },
                  child: Text(
                    'Sign up',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: 'Password',
          border: TextFieldOutlineBorder(scheme: theme.colorScheme),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              setState(() => _obscureText = !_obscureText);
            },
          ),
        ),
      ),
    );
  }
}
