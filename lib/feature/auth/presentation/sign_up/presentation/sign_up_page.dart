import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/feature/auth/data/mock_auth_repository.dart';
import 'package:sport_calendart_app/feature/auth/presentation/sign_up/bloc/register_bloc.dart';

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
    return BlocProvider<RegisterBloc>(
      create: (_) => RegisterBloc(MockAuthRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Регистрация',
            style: TextStyle(fontSize: 32),
          ),
        ),
        body: BlocConsumer<RegisterBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              // Navigate to the home page on success
              context.go('/home_routes/home');
            } else if (state is RegisterFailure) {
              // Show error message on failure
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Email input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('E-mail'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 14,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6),
                            child: Icon(Icons.email),
                          ),
                          hintText: 'example@mail.com',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Password input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Пароль'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6),
                            child: Icon(Icons.password),
                          ),
                          hintText: '6 символов',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Confirm password input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Повторите пароль'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 6),
                            child: Icon(Icons.password),
                          ),
                          hintText: '6 символов',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Registration button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: state is! RegisterLoading
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

                              // Trigger registration event
                              context.read<RegisterBloc>().add(
                                    RegisterEvent(
                                      login: login,
                                      password: password,
                                    ),
                                  );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      child: state is RegisterLoading
                          ? const CircularProgressIndicator()
                          : const Center(
                              child: Text('Зарегистрироваться'),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Navigate to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('У вас есть аккаунт?'),
                      TextButton(
                        onPressed: () => context.go('/auth_routes/sign_in'),
                        child: const Text(
                          'Войти',
                          style: TextStyle(color: Colors.lightBlue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
