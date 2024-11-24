import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/core/router/routes_enum.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/auth/presentation/auth_scope.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Профиль',
            style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
          ),
          IconButton(
              onPressed: () {
                AuthScope.of(context).signOut();
                context.go(AuthRoutes.signIn.path);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
