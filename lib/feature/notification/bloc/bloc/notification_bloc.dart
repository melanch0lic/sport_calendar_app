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
    on<NotificationEvent>((event, emit) {
      switch (event.runtimeType) {
        case InitializeNotifications:
          _onInitializeNotifications(event as InitializeNotifications, emit);
        // case UpdateFcmToken:
        //   _onUpdateFcmToken(event as UpdateFcmToken, emit);
      }
    });
  }

  Future<void> _onInitializeNotifications(InitializeNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());

    try {
      final firebaseMessaging = FirebaseMessaging.instance;
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
        add(UpdateFcmToken(oldToken: oldToken, newToken: newToken));
      } else {
        emit(NotificationSuccess());
      }
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateFcmToken(UpdateFcmToken event, Emitter<NotificationState> emit) async {
    try {
      final success = await notificationRepository.updateFcmToken(
        oldToken: event.oldToken,
        newToken: event.newToken,
      );

      if (success) {
        emit(NotificationSuccess());
        // Subscribe to default topics or other necessary actions
        await notificationRepository.subscribeToTopic('default-notifications');
      } else {
        emit(NotificationFailure('Failed to update FCM token on server.'));
      }
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }
}
