import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_bloc.dart';
import 'package:sport_calendart_app/feature/auth/presentation/auth_scope.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

import '../../../../../core/utils/text_field_outline_border.dart';
import '../../data/bloc/bloc/auth_state.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
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
                  'Подвтерждение',
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
                    controller: _otpController,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Otp',
                      border: TextFieldOutlineBorder(
                        scheme: theme.colorScheme,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 48,
                  child: BlocListener<AuthBloc, AuthState>(
                    bloc: DependenciesScope.of(context).resolve<AuthBloc>(),
                    listener: (context, state) {
                      if (state is AuthAuthenticated) {
                        context.go('/home_routes/home');
                      }

                      if (state is AuthOtpSentError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Произошла ошибка при отправке кода')),
                        );
                      }
                    },
                    child: FilledButton(
                      style: theme.elevatedButtonTheme.style,
                      onPressed: () {
                        AuthScope.of(context).checkEmailCode(_otpController.text);
                      },
                      child: Text(
                        'Подтвердить',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
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
