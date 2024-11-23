import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_calendart_app/feature/notification/bloc/bloc/notification_bloc.dart';
import 'package:sport_calendart_app/feature/notification/domain/repositories/notification_repository.dart';

import '../../../runner/dependency_scope.dart';
import '../bloc/bloc/notification_event.dart';

@immutable
class NotificationScope extends StatelessWidget {
  final Widget child;

  const NotificationScope({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    final bloc =
        NotificationBloc(notificationRepository: DependenciesScope.of(context).resolve<NotificationRepository>())
          ..add(InitializeNotifications());
    return BlocProvider<NotificationBloc>(
      create: (context) => bloc,
      child: child,
    );
  }
}
