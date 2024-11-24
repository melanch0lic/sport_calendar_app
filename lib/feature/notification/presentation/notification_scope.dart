import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_calendart_app/core/utils/extension/src/context_extension.dart';
import 'package:sport_calendart_app/feature/notification/bloc/bloc/notification_bloc.dart';
import 'package:sport_calendart_app/feature/notification/domain/repositories/notification_repository.dart';

import '../../../runner/dependency_scope.dart';
import '../bloc/bloc/notification_event.dart';
import '../bloc/bloc/notification_state.dart';

abstract interface class NotificationController {
  void subscribeToTopic(String topic);

  void unsubscribeFromTopic(String topic);
}

@immutable
class NotificationScope extends StatefulWidget {
  final Widget child;

  static NotificationScope readOf(BuildContext context) => context.read<NotificationScope>();

  static NotificationController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_NotificationInherited>(listen: listen).controller;

  const NotificationScope({required this.child, super.key});

  @override
  State<NotificationScope> createState() => _NotificationScopeState();
}

class _NotificationScopeState extends State<NotificationScope> implements NotificationController {
  late final NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();
    _notificationBloc =
        NotificationBloc(notificationRepository: DependenciesScope.of(context).resolve<NotificationRepository>());
  }

  @override
  void subscribeToTopic(String topic) => _notificationBloc.add(
        SubscribeToTopic(topic),
      );

  @override
  void unsubscribeFromTopic(String topic) => _notificationBloc.add(
        UnsubscribeFromTopic(topic),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationBloc>(
      lazy: false,
      create: (context) => _notificationBloc..add(InitializeNotifications()),
      child: _NotificationInherited(state: _notificationBloc.state, controller: this, child: widget.child),
    );
  }
}

final class _NotificationInherited extends InheritedWidget {
  final NotificationController controller;
  final NotificationState state;

  const _NotificationInherited({required super.child, required this.controller, required this.state});

  @override
  bool updateShouldNotify(covariant _NotificationInherited oldWidget) => state != oldWidget.state;
}
