import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/auto_scrolling_listview.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/home_appbar.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/icon_with_notify_circle.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/personality_competition_card.dart';
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
                                            physics: NeverScrollableScrollPhysics(),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                TitlePlaceholder(width: double.infinity),
                                                SizedBox(height: 16.0),
                                                ContentPlaceholder(
                                                  lineType: ContentLineType.threeLines,
                                                ),
                                                SizedBox(height: 16.0),
                                                TitlePlaceholder(width: 200.0),
                                                SizedBox(height: 16.0),
                                                ContentPlaceholder(
                                                  lineType: ContentLineType.twoLines,
                                                ),
                                                SizedBox(height: 16.0),
                                                TitlePlaceholder(width: 200.0),
                                                SizedBox(height: 16.0),
                                                ContentPlaceholder(
                                                  lineType: ContentLineType.twoLines,
                                                ),
                                              ],
                                            ),
                                          ));
                                    }
                                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                      const SizedBox(height: 100),
                                    ]);
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
