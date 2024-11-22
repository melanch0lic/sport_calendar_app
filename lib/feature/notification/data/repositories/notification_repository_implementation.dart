import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_calendart_app/feature/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImplementation implements NotificationRepository {
  final FirebaseMessaging _firebaseMessaging;
  final SharedPreferences _sharedPreferences;

  NotificationRepositoryImplementation(this._firebaseMessaging, this._sharedPreferences);

  @override
  Future<String?> getSavedFcmToken() async {
    return _sharedPreferences.getString('fcmToken');
  }

  @override
  Future<bool> updateFcmToken({String? oldToken, required String newToken}) async {
    try {
      // Simulate sending tokens to your server
      //TODO updateFcmToken
      print('Updating FCM token on server...');
      print('Old Token: $oldToken');
      print('New Token: $newToken');
      // Perform your API call here.
      _sharedPreferences.setString('fcmToken', newToken);
      return true;
    } catch (e) {
      print('Failed to update FCM token: $e');
      return false;
    }
  }

  @override
  Future<bool> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
      return true;
    } catch (e) {
      print('Failed to subscribe to topic $topic: $e');
      return false;
    }
  }

  @override
  Future<bool> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
      return true;
    } catch (e) {
      print('Failed to unsubscribe from topic $topic: $e');
      return false;
    }
  }
}
