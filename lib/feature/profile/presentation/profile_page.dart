import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/placeholders.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/presentation_container_dropdown.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/custom_button.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/dropdown_container.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/profile_appbar.dart';

import '../../../core/resources/assets.gen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const ProfileAppbar(),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromRGBO(236, 239, 243, 1),
                  child: SvgPicture.asset(
                    Assets.icons.profile.path,
                    color: const Color.fromRGBO(107, 110, 117, 1),
                    width: 55,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Yakudzae@mail.ru',
                  style: CommonTextStyles().title2.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Предпочтения',
                          style: CommonTextStyles().largeTitle.copyWith(
                                color: const Color.fromRGBO(29, 31, 36, 1),
                              ),
                        ),
                        SvgPicture.asset('assets/icons/Plus.svg')
                      ],
                    ),
                    const SizedBox(height: 16),
                    const DropdownContainer(name: 'Виды спорта', content: SizedBox()),
                    const DropdownContainer(name: 'Дисциплины', content: SizedBox()),
                    const DropdownContainer(name: 'Места проведения', content: SizedBox()),
                    const DropdownContainer(name: 'Возрастная категория', content: SizedBox()),
                    const CustomButton(
                      name: 'Сохранить изменения',
                      backColor: Color.fromRGBO(67, 84, 250, 1),
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    const CustomButton(
                      name: 'Удалить',
                      backColor: Colors.white,
                      textColor: Color.fromRGBO(255, 82, 71, 1),
                      colorBorder: Color.fromRGBO(255, 82, 71, 1),
                    ),
                    const SizedBox(height: 36),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Отслеживаемые соревнования',
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
              )
            ],
          ),
        )
      ],
    );
  }
}
