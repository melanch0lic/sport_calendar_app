import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class NavigateToRegister extends StatelessWidget {
  const NavigateToRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Еще нет аккаунта?',
            style: CommonTextStyles().body.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          ),
          InkWell(
            onTap: () => context.go('/auth_routes/sign_up'),
            child: Text(
              ' Создайте его',
              style: CommonTextStyles()
                  .body
                  .copyWith(fontSize: 16, color: const Color.fromRGBO(67, 84, 250, 1), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
