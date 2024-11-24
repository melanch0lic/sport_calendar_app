import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_bloc.dart';
import 'package:sport_calendart_app/feature/auth/presentation/sign_in/components/navigate_to_register.dart';
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
      body: Stack(
        children: [
          Align(alignment: Alignment.topRight, child: Image.asset('assets/images/bubbles.png')),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 120),
                            child: Text(
                              'Авторизация',
                              textAlign: TextAlign.center,
                              style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 36),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style:
                                      CommonTextStyles().body.copyWith(color: const Color.fromRGBO(107, 110, 117, 1)),
                                ),
                                const SizedBox(height: 8),
                                _EmailTextField(controller: _emailController),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Пароль',
                                  style:
                                      CommonTextStyles().body.copyWith(color: const Color.fromRGBO(107, 110, 117, 1)),
                                ),
                                const SizedBox(height: 8),
                                _PasswordTextField(controller: _passwordController),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Забыли пароль?',
                            style: CommonTextStyles()
                                .body
                                .copyWith(color: const Color.fromRGBO(67, 84, 250, 1), fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          SizedBox(
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(67, 84, 250, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  AuthScope.of(context).signInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    'Войти',
                                    style: CommonTextStyles().body.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const NavigateToRegister(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailTextField extends StatefulWidget {
  const _EmailTextField({required this.controller});

  final TextEditingController controller;

  @override
  State<_EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<_EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintStyle: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
          hintText: 'example@mail.ru',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(211, 213, 218, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(67, 84, 250, 1),
            ),
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
          hintText: '\u2022 \u2022 \u2022 \u2022 \u2022 \u2022 \u2022 \u2022',
          hintStyle: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
          border: TextFieldOutlineBorder(scheme: theme.colorScheme),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(211, 213, 218, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(67, 84, 250, 1),
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: const Color.fromRGBO(107, 110, 117, 1),
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
