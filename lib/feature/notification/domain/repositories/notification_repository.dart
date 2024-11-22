abstract interface class NotificationRepository {
  Future<String?> getSavedFcmToken();
  Future<bool> updateFcmToken({
    String? oldToken,
    required String newToken,
  });
  Future<bool> subscribeToTopic(String topic);
  Future<bool> unsubscribeFromTopic(String topic);
}
