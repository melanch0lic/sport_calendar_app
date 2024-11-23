import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/icon_with_notify_circle.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.15,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      backgroundColor: const Color.fromRGBO(29, 31, 36, 1),
      floating: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Здравствуйте!', style: CommonTextStyles().largeTitle),
              const SizedBox(height: 5),
              Text('Посмотрим, какие состязания ждут вас', style: CommonTextStyles().smallTitle),
              const SizedBox(height: 5)
            ],
          ),
          const Column(
            children: [
              IconWithNotifyCircle(icon: 'assets/icons/bell.svg'),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
