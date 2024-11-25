import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/calendar/presentation/components/calendar_appbar.dart';
import 'package:sport_calendart_app/feature/calendar/presentation/components/calendar_container.dart';
import 'package:sport_calendart_app/feature/calendar/presentation/components/search_text_field.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/icon_with_notify_circle.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/placeholders.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/presentation_container_dropdown.dart';
import 'package:sport_calendart_app/feature/home/presentation/home_scope.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return HomeScope(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh is possible
        slivers: [
          const CalendarAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  const SearchTextField(),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Результаты поиска',
                        style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                      ),
                      BlocBuilder<EventBloc, EventState>(builder: (context, state) {
                        if (state is EventLoading) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: const SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TitlePlaceholder(width: double.infinity),
                                  SizedBox(height: 16.0),
                                  ContentPlaceholder(lineType: ContentLineType.threeLines),
                                  SizedBox(height: 16.0),
                                  TitlePlaceholder(width: 200.0),
                                  SizedBox(height: 16.0),
                                  ContentPlaceholder(lineType: ContentLineType.twoLines),
                                  SizedBox(height: 16.0),
                                  TitlePlaceholder(width: 200.0),
                                  SizedBox(height: 16.0),
                                  ContentPlaceholder(lineType: ContentLineType.twoLines),
                                ],
                              ),
                            ),
                          );
                        } else if (state is EventLoaded) {
                          Map<String, List<EventData>> groupedEvents = {};
                          for (var event in state.events) {
                            if (groupedEvents[event.sportTypeId] == null) {
                              groupedEvents[event.sportTypeId] = [];
                            }
                            groupedEvents[event.sportTypeId]?.add(event);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 36),
                            child: ListView.separated(
                              physics: const PageScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: groupedEvents.keys.length,
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                String sportTypeId = groupedEvents.keys.elementAt(index);
                                List<EventData> events = groupedEvents[sportTypeId]!;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PresentationContainerDropdown(
                                      sportTypeId: sportTypeId,
                                      events: events,
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        } else if (state is EventError) {
                          return Center(child: Text(state.message));
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
