import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_bloc.dart';
import 'package:sport_calendart_app/feature/auth/presentation/auth_scope.dart';
import 'package:sport_calendart_app/feature/auth/presentation/otp_page/components/refresh_code.dart';

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
                              'Подтверждение',
                              textAlign: TextAlign.center,
                              style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Для завершения регистрации введите код,\nкоторый мы отправили на ваш Email',
                            style: CommonTextStyles().body.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            'Код из письма',
                            style: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(107, 110, 117, 1)),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 48,
                            child: TextField(
                              controller: _otpController,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                hintText: '_ _ _ _ _ _',
                                hintStyle:
                                    CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
                                border: TextFieldOutlineBorder(
                                  scheme: theme.colorScheme,
                                ),
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
                          ),
                          const Spacer(),
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
                                  context.go('/auth_routes/pref');
                                  if (state is AuthOtpSentError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Произошла ошибка при отправке кода')),
                                    );
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
                                    AuthScope.of(context).checkEmailCode(_otpController.text);
                                  },
                                  child: Center(
                                    child: Text(
                                      'Подтвердить',
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
                          ),
                          const RefreshCode()
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
