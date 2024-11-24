import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/personality_competition_card.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/custom_button.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/profile_appbar.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/profile_dropdown.dart';

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
                    'assets/icons/profile.svg',
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
                    const ProfileDropdown(name: 'Виды спорта'),
                    const ProfileDropdown(name: 'Дисциплины'),
                    const ProfileDropdown(name: 'Места проведения'),
                    const ProfileDropdown(name: 'Возрастная категория'),
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
                    Text(
                      'Отслеживаемыые\nсоревнования',
                      style: CommonTextStyles().largeTitle.copyWith(
                            color: const Color.fromRGBO(29, 31, 36, 1),
                          ),
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
              )
            ],
          ),
        )
      ],
    );
  }
}
