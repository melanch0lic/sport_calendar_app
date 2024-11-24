import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/personality_competition_card.dart';

class ContainerDropdown extends StatefulWidget {
  const ContainerDropdown({
    super.key,
    required this.events,
    required this.sportTypeId,
  });

  final List<EventData> events;
  final String sportTypeId;
  @override
  State<ContainerDropdown> createState() => _ContainerDropdownState();
}

class _ContainerDropdownState extends State<ContainerDropdown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.sportTypeId,
                style: CommonTextStyles().title2.copyWith(fontSize: 20),
              ),
              RotatedBox(
                quarterTurns: isExpanded ? 2 : 0,
                child: SvgPicture.asset('assets/icons/down_arrow.svg'),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: widget.events.map((event) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PersonalityCompetitionCard(event: event),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
