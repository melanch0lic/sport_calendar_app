// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhQTY6Z9F0p3mfxzDK5GAx-vGSSoXW8OA',
    appId: '1:884661616216:web:eb2885e245bb6a3219942d',
    messagingSenderId: '884661616216',
    projectId: 'sportcalendar-ca1f8',
    authDomain: 'sportcalendar-ca1f8.firebaseapp.com',
    storageBucket: 'sportcalendar-ca1f8.firebasestorage.app',
    measurementId: 'G-3EP2JVQD6B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZuaI7JYQRaDjV87n2SIb0banWR72H-1Q',
    appId: '1:884661616216:android:c653ea497dabdfcf19942d',
    messagingSenderId: '884661616216',
    projectId: 'sportcalendar-ca1f8',
    storageBucket: 'sportcalendar-ca1f8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3h2uHwbj8s3XGqwDxm-7ETNKwBMnh8m4',
    appId: '1:884661616216:ios:1d24512f2b9c2f8f19942d',
    messagingSenderId: '884661616216',
    projectId: 'sportcalendar-ca1f8',
    storageBucket: 'sportcalendar-ca1f8.firebasestorage.app',
    iosBundleId: 'com.example.cleanTemplateFlutterProject',
  );
}
