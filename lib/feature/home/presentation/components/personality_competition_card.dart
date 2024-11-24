import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/upcoming_competitons_card.dart';

class PersonalityCompetitionCard extends StatelessWidget {
  const PersonalityCompetitionCard({
    super.key,
    required this.event,
  });

  final EventData event;
  @override
  Widget build(BuildContext context) {
    final bool isActive = event.eventStartDate.isBefore(DateTime.now().toUtc().add(const Duration(days: 1)));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color.fromRGBO(236, 239, 243, 1)),
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
                  color: const Color.fromRGBO(67, 84, 250, 1),
                ),
                const SizedBox(width: 5),
                Text(
                  '${formatTimestamp(event.eventStartDate.toIso8601String())} — ${formatTimestamp(event.eventEndDate.toIso8601String())}',
                  style: CommonTextStyles().cardBody.copyWith(
                        color: isActive ? const Color.fromRGBO(107, 110, 117, 1) : const Color.fromRGBO(255, 82, 71, 1),
                      ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: const Color.fromRGBO(67, 84, 250, 1),
                ),
                const SizedBox(width: 5),
                Text('${event.eventParticipants} участников',
                    style: CommonTextStyles().cardBody.copyWith(
                          color: isActive
                              ? const Color.fromRGBO(107, 110, 117, 1)
                              : const Color.fromRGBO(107, 110, 117, 0.5),
                        )),
              ]),
              SvgPicture.asset(
                'assets/icons/more_vert.svg',
                color: const Color.fromRGBO(67, 84, 250, 1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            event.eventName,
            style: CommonTextStyles().cardName.copyWith(
                color: isActive ? const Color.fromRGBO(29, 31, 36, 1) : const Color.fromRGBO(29, 31, 36, 0.5)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                event.eventGender,
                style: CommonTextStyles().cardBody.copyWith(
                      fontWeight: FontWeight.w400,
                      color:
                          isActive ? const Color.fromRGBO(107, 110, 117, 1) : const Color.fromRGBO(107, 110, 117, 0.5),
                    ),
              ),
              const SizedBox(width: 12),
              Text(
                'От ${event.eventAgeMin}— до ${event.eventAgeMax} лет',
                style: CommonTextStyles().cardBody.copyWith(
                      fontWeight: FontWeight.w400,
                      color: isActive ? const Color.fromRGBO(58, 61, 68, 1) : const Color.fromRGBO(58, 61, 68, 0.5),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            event.eventLocation,
            style: CommonTextStyles().cardTitle.copyWith(
                  fontWeight: FontWeight.w400,
                  color: isActive ? const Color.fromRGBO(58, 61, 68, 1) : const Color.fromRGBO(58, 61, 68, 0.5),
                ),
          ),
        ],
      ),
    );
  }
}
