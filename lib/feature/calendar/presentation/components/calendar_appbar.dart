import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class CalendarAppbar extends StatelessWidget {
  const CalendarAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'Календарь событий',
        style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
      ),
    );
  }
}
