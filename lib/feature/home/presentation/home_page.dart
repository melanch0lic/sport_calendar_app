import 'package:flutter/material.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/home_appbar.dart';
import 'package:sport_calendart_app/feature/notification/presentation/notification_scope.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotificationScope(
      child: CustomScrollView(
        slivers: [
          HomeAppBar(),
        ],
      ),
    );
  }
}
