import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/icon_with_notify_circle.dart';

class CalendarAppbar extends StatelessWidget {
  const CalendarAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Календарь событий',
            style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
          ),
          const Column(
            children: [
              IconWithNotifyCircle(
                icon: 'assets/icons/bell.svg',
                color: Color.fromRGBO(29, 31, 36, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
