import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class UpcomingCompetitonsCard extends StatefulWidget {
  const UpcomingCompetitonsCard({
    super.key,
  });

  @override
  State<UpcomingCompetitonsCard> createState() => _UpcomingCompetitonsCardState();
}

class _UpcomingCompetitonsCardState extends State<UpcomingCompetitonsCard> {
  static final List<Color> _listColors = [
    Color.fromRGBO(255, 82, 38, 1),
    Color.fromRGBO(27, 28, 33, 1),
    Color.fromRGBO(237, 155, 22, 1),
    Color.fromRGBO(27, 141, 33, 1),
    Color.fromRGBO(114, 87, 255, 1),
  ];

  static int _currentColorIndex = 0;

  Color _getNextColor() {
    final color = _listColors[_currentColorIndex];
    _currentColorIndex = (_currentColorIndex + 1) % _listColors.length;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getNextColor();
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Велосипедный спорт', style: CommonTextStyles().cardTitle),
                  SvgPicture.asset('assets/icons/more_vert.svg'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/schedule.svg'),
                  const SizedBox(width: 5),
                  Text('16 фев -- 19 фев', style: CommonTextStyles().cardBody),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/icons/profile.svg'),
                  const SizedBox(width: 5),
                  Text('25 участников', style: CommonTextStyles().cardBody)
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Кубок России',
                style: CommonTextStyles().cardName,
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
                        ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'До 15 лет',
                    style: CommonTextStyles().cardBody.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Россия, Город Санкт-Петербург',
                style: CommonTextStyles().cardTitle.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
        Image.asset('assets/images/pattern.png', scale: 0.7),
      ],
    );
  }
}
