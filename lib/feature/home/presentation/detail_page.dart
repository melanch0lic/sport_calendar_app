import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/core/utils/extension/extensions.dart';
import 'package:sport_calendart_app/feature/home/domain/entity/event_data.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/upcoming_competitons_card.dart';
import 'package:sport_calendart_app/feature/notification/presentation/notification_scope.dart';
import 'package:sport_calendart_app/feature/profile/presentation/components/dropdown_container.dart';

import '../../../core/resources/assets.gen.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.event});

  final EventData event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              width: 15,
              height: 15,
              Assets.icons.arrowLeft.path,
            ),
            onPressed: () => context.pop(),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          pinned: true,
          forceMaterialTransparency: true,
          stretch: true,
          expandedHeight: 220.0,
          backgroundColor: Colors.white,
          elevation: 0.0,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
            background: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Color.fromRGBO(29, 31, 36, 1)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1.3,
                    child: Image.asset(
                      Assets.images.pattern.path,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      event.eventName,
                      style: CommonTextStyles().largeTitle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Stack(
              children: [
                Container(
                    height: 32,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    )),
                Align(
                  heightFactor: 0.1,
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.only(right: 16),
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // Set border radius here
                          ),
                        ),
                        onPressed: () {
                          _showNotificationDialog(context);
                        },
                        child: Row(children: [
                          SvgPicture.asset(Assets.icons.bell.path, width: 24, height: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Отслеживать',
                            style: TextStyle(fontSize: 16),
                          )
                        ])),
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.calendar.path,
                          width: 24,
                          height: 24,
                          color: context.theme.commonColors.indigo,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${formatTimestamp(event.eventStartDate.toIso8601String())} — ${formatTimestamp(event.eventEndDate.toIso8601String())}',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.profile.path,
                          width: 24,
                          height: 24,
                          color: context.theme.commonColors.indigo,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${event.eventParticipants} участников',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.malefemale.path,
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${event.eventGender} от ${event.eventAgeMin} лет',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.location.path,
                      color: context.theme.commonColors.indigo,
                      width: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event.eventLocation,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DropdownContainer(
                  name: 'Виды спорта',
                  content: TagWidgetEvent(
                    name: event.sportTypeId,
                  ),
                ),
                DropdownContainer(
                    name: 'Дисциплины',
                    content: TagWidgetEvent(
                      name: event.disciplinesData.first,
                    )),
                DropdownContainer(
                  name: 'Описание',
                  content: Text(
                    'Здесь могло бы быть ваше описание...',
                    style: CommonTextStyles().body,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class TagWidgetEvent extends StatelessWidget {
  const TagWidgetEvent({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(239, 246, 255, 1),
          side: const BorderSide(
            color: Color.fromRGBO(67, 84, 250, 1),
            width: 1, // Border width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          name,
          style: CommonTextStyles().body,
        ),
      ),
    );
  }
}

void _showNotificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Уведомления о событии'),
      content: const Text('Вы хотите получать уведомления?'),
      actions: [
        TextButton(
          onPressed: () {
            NotificationScope.of(context).subscribeToTopic('sport');
            Navigator.of(context).pop();
            _showSnackBar(context, 'Вы отписались от уведомлений.');
          },
          child: const Text('Нет'),
        ),
        TextButton(
          onPressed: () {
            NotificationScope.of(context).subscribeToTopic('sport');
            Navigator.of(context).pop();
            _showSnackBar(context, 'Вы подписались на уведомления.');
          },
          child: const Text('Да'),
        ),
      ],
    ),
  );
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
