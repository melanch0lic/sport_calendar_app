sealed class NotificationEvent {}

class InitializeNotifications extends NotificationEvent {}

class SubscribeToTopic extends NotificationEvent {
  final String topic;

  SubscribeToTopic(this.topic);
}

class UnsubscribeFromTopic extends NotificationEvent {
  final String topic;
  UnsubscribeFromTopic(this.topic);
}

class UpdateFcmToken extends NotificationEvent {
  final String? oldToken;
  final String newToken;

  UpdateFcmToken({this.oldToken, required this.newToken});
}
