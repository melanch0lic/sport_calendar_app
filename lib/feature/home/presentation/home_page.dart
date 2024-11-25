import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/core/ui_kit/column_builder.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/auto_scrolling_listview.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/home_appbar.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/icon_with_notify_circle.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/presentation_container_dropdown.dart';
import 'package:sport_calendart_app/feature/home/presentation/home_scope.dart';

import 'components/placeholders.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScope(
      child: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(29, 31, 36, 1),
          ),
          CustomScrollView(
            slivers: [
              const HomeAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Активные фильтры соревнований',
                                    style: CommonTextStyles().title2,
                                  ),
                                  const IconWithNotifyCircle(icon: 'assets/icons/filter.svg')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ближайшие состязания',
                                    style: CommonTextStyles()
                                        .largeTitle
                                        .copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                                  ),
                                  SvgPicture.asset('assets/icons/more.svg')
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            const AutoScrollingListView(),
                            const SizedBox(height: 36),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Соревнования для вас',
                                    style: CommonTextStyles()
                                        .largeTitle
                                        .copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                                  ),
                                  const SizedBox(height: 16),
                                  BlocBuilder<EventBloc, EventState>(builder: (context, state) {
                                    if (state is EventLoading) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: const SingleChildScrollView(
                                          padding: EdgeInsets.only(bottom: 36, top: 16),
                                          physics: NeverScrollableScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              TitlePlaceholder(width: double.infinity),
                                              SizedBox(height: 16.0),
                                              ContentPlaceholder(lineType: ContentLineType.threeLines),
                                              SizedBox(height: 16.0),
                                              TitlePlaceholder(width: double.infinity),
                                              SizedBox(height: 16.0),
                                              ContentPlaceholder(lineType: ContentLineType.threeLines),
                                              SizedBox(height: 16.0),
                                              TitlePlaceholder(width: double.infinity),
                                              SizedBox(height: 16.0),
                                              ContentPlaceholder(lineType: ContentLineType.threeLines),
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

                                      return ColumnBuilder.separator(
                                        // physics: const PageScrollPhysics(),
                                        itemCount: groupedEvents.keys.length,
                                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                                        itemBuilder: (context, index) {
                                          String sportTypeId = groupedEvents.keys.elementAt(index);
                                          List<EventData> events = groupedEvents[sportTypeId]!;

                                          return PresentationContainerDropdown(
                                            sportTypeId: sportTypeId,
                                            events: events,
                                          );
                                        },
                                      );
                                    } else if (state is EventError) {
                                      return Center(child: Text(state.message));
                                    }
                                    return const Center(child: CircularProgressIndicator());
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
