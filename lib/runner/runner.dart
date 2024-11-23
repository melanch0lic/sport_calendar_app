import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_calendart_app/core/services/di_container/di_container.dart';
import 'package:sport_calendart_app/feature/notification/data/repositories/notification_repository_implementation.dart';
import 'package:sport_calendart_app/firebase_options.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

import '../core/environment/app_environment.dart';
import '../core/splash_util/splash_util.dart';
import '../feature/app/app.dart';
import '../feature/notification/domain/repositories/notification_repository.dart';
import 'init_config/init_config.dart';

/// App launch.
Future<void> run() => InitConfig.run<Future<void>>(
      () async {
        final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        );
        await initFirebaseServices();
        final diContainer = await _initDependencies();

        SplashUtil.removeSplash();
        runApp(DependenciesScope(dependencies: diContainer, child: const StreakerApp()));
      },
    );

Future<void> initFirebaseServices() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

Future<DIContainer> _initDependencies() async {
  final diContainer = DIContainer();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final prefs = await SharedPreferences.getInstance();

  diContainer.registerSingleton<NotificationRepository>(NotificationRepositoryImplementation(firebaseMessaging, prefs));

  return diContainer;
}

Future<void> _initDotEnv() async {
  await dotenv.load();
  final config = AppEnvironment<AppConfig>.instance().config;
  AppEnvironment.instance().config = config.copyWith(
    url: dotenv.env['API_HOST'],
  );
}
