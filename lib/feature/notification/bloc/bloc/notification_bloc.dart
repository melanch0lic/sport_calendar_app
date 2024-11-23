import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({
    required this.notificationRepository,
  }) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      switch (event.runtimeType) {
        case InitializeNotifications:
          await _onInitializeNotifications(event as InitializeNotifications, emit);
      }
    });
  }

  Future<void> _onInitializeNotifications(InitializeNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());

    try {
      final firebaseMessaging = FirebaseMessaging.instance;
      final settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('Уведомления разрешены');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('Разрешены временные уведомления');
      } else {
        print('Уведомления не разрешены');
      }
      final newToken = await firebaseMessaging.getToken();
      print(newToken);
      if (newToken == null) {
        emit(NotificationFailure('Failed to retrieve FCM token.'));
        return;
      }

      final oldToken = await notificationRepository.getSavedFcmToken();

      if (oldToken != newToken) {
        await notificationRepository.updateFcmToken(
          oldToken: oldToken,
          newToken: newToken,
        );
      }
      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }
}
