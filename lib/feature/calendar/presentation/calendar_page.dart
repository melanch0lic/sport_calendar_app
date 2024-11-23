import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/calendar/presentation/components/calendar_appbar.dart';
import 'package:sport_calendart_app/feature/calendar/presentation/components/calendar_container.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/icon_with_notify_circle.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/personality_competition_card.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CalendarAppbar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                const CalendarContainer(),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Активные фильтры соревнований',
                      style: CommonTextStyles().title2,
                    ),
                    const IconWithNotifyCircle(icon: 'assets/icons/filter.svg')
                  ],
                ),
                const SizedBox(height: 36),
                Text(
                  'Результаты поиска',
                  style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Авиамодельный спорт',
                      style: CommonTextStyles().title2.copyWith(fontSize: 20),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset('assets/icons/down_arrow.svg'),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text('Основной состав', style: CommonTextStyles().title2),
                const SizedBox(height: 12),
                const PersonalityCompetitionCard(),
                const SizedBox(height: 16),
                const PersonalityCompetitionCard(),
                const SizedBox(height: 16),
                const PersonalityCompetitionCard(),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
