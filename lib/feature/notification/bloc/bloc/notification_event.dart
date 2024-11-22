sealed class NotificationEvent {}

class InitializeNotifications extends NotificationEvent {}

class UpdateFcmToken extends NotificationEvent {
  final String? oldToken;
  final String newToken;

  UpdateFcmToken({this.oldToken, required this.newToken});
}
