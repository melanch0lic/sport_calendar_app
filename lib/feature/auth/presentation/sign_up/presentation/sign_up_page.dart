import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/core/router/routes_enum.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_bloc.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_state.dart';
import 'package:sport_calendart_app/feature/auth/presentation/auth_scope.dart';
import 'package:sport_calendart_app/feature/auth/presentation/sign_up/components/checkbox_agreement.dart';
import 'package:sport_calendart_app/feature/auth/presentation/sign_up/components/navigate_to_login.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: DependenciesScope.of(context).resolve<AuthBloc>(),
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to the home page on success
            context.go('/home_routes/home');
          } else if (state is AuthError) {
            // Show error message on failure
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Align(alignment: Alignment.topRight, child: Image.asset('assets/images/bubbles.png')),
              SafeArea(
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 120),
                                  child: Text(
                                    'Регистрация',
                                    textAlign: TextAlign.center,
                                    style: CommonTextStyles()
                                        .largeTitle
                                        .copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 36),
                                  child: Text(
                                    'Email',
                                    style: CommonTextStyles().body.copyWith(
                                          color: const Color.fromRGBO(107, 110, 117, 1),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _EmailTextField(controller: _loginController),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Пароль',
                                  style: CommonTextStyles().body.copyWith(
                                        color: const Color.fromRGBO(107, 110, 117, 1),
                                      ),
                                ),
                                const SizedBox(height: 8),
                                _PasswordTextField(controller: _passwordController)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Повторите пароль',
                                  style: CommonTextStyles().body.copyWith(
                                        color: const Color.fromRGBO(107, 110, 117, 1),
                                      ),
                                ),
                                const SizedBox(height: 8),
                                _ConfirmPasswordTextField(controller: _confirmPasswordController)
                              ],
                            ),
                            const SizedBox(height: 24),
                            const CheckboxAgreement(),
                            const Spacer(),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: state is! AuthLoading
                                    ? () {
                                        final login = _loginController.text.trim();
                                        final password = _passwordController.text.trim();
                                        final confirmPassword = _confirmPasswordController.text.trim();

                                        if (login.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Все поля должны быть заполнены')),
                                          );
                                          return;
                                        }

                                        if (password != confirmPassword) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Пароли не совпадают')),
                                          );
                                          return;
                                        }

                                        AuthScope.of(context).signUp(login, password);
                                        context.push(AuthRoutes.otp.path);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(67, 84, 250, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator()
                                    : Center(
                                        child: Text(
                                          'Создать аккаунт',
                                          style: CommonTextStyles().body.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                              ),
                            ),
                            const NavigateToLogin(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
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
  const _PasswordTextField({required this.controller});
  final TextEditingController controller;
  @override
  State<_PasswordTextField> createState() => __PasswordTextFieldState();
}

bool _obscureText = true;

class __PasswordTextFieldState extends State<_PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: '6 символов',
          hintStyle: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
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

class _ConfirmPasswordTextField extends StatefulWidget {
  const _ConfirmPasswordTextField({required this.controller});
  final TextEditingController controller;
  @override
  State<_ConfirmPasswordTextField> createState() => _ConfirmPasswordTextFieldState();
}

bool _obscureTextConfirm = true;

class _ConfirmPasswordTextFieldState extends State<_ConfirmPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureTextConfirm,
        decoration: InputDecoration(
          hintText: '6 символов',
          hintStyle: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
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
              _obscureTextConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: const Color.fromRGBO(107, 110, 117, 1),
            ),
            onPressed: () {
              setState(() => _obscureTextConfirm = !_obscureTextConfirm);
            },
          ),
        ),
      ),
    );
  }
}
