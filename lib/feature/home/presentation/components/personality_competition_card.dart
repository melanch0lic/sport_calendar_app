import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class PersonalityCompetitionCard extends StatelessWidget {
  const PersonalityCompetitionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = DateTime.now().month == DateTime.march ? true : false;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromRGBO(236, 239, 243, 1)),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SvgPicture.asset(
                  'assets/icons/schedule.svg',
                  color: Color.fromRGBO(67, 84, 250, 1),
                ),
                const SizedBox(width: 5),
                Text(
                  '16 фев -- 19 фев',
                  style: CommonTextStyles().cardBody.copyWith(
                        color: isActive ? const Color.fromRGBO(107, 110, 117, 1) : const Color.fromRGBO(255, 82, 71, 1),
                      ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: Color.fromRGBO(67, 84, 250, 1),
                ),
                const SizedBox(width: 5),
                Text('25 участников',
                    style: CommonTextStyles().cardBody.copyWith(
                          color: isActive ? Color.fromRGBO(107, 110, 117, 1) : Color.fromRGBO(107, 110, 117, 0.5),
                        )),
              ]),
              SvgPicture.asset(
                'assets/icons/more_vert.svg',
                color: Color.fromRGBO(67, 84, 250, 1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Кубок России',
            style: CommonTextStyles().cardName.copyWith(
                color: isActive ? const Color.fromRGBO(29, 31, 36, 1) : const Color.fromRGBO(29, 31, 36, 0.5)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Юноши, девушки',
                style: CommonTextStyles().cardBody.copyWith(
                      fontWeight: FontWeight.w400,
                      color: isActive ? Color.fromRGBO(107, 110, 117, 1) : Color.fromRGBO(107, 110, 117, 0.5),
                    ),
              ),
              const SizedBox(width: 12),
              Text(
                'До 15 лет',
                style: CommonTextStyles().cardBody.copyWith(
                      fontWeight: FontWeight.w400,
                      color: isActive ? Color.fromRGBO(58, 61, 68, 1) : Color.fromRGBO(58, 61, 68, 0.5),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Россия, Город Санкт-Петербург',
            style: CommonTextStyles().cardTitle.copyWith(
                  fontWeight: FontWeight.w400,
                  color: isActive ? Color.fromRGBO(58, 61, 68, 1) : Color.fromRGBO(58, 61, 68, 0.5),
                ),
          ),
        ],
      ),
    );
  }
}
