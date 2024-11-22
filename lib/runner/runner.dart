import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sport_calendart_app/core/services/di_container/di_container.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

import '../core/environment/app_environment.dart';
import '../core/splash_util/splash_util.dart';
import '../feature/app/app.dart';
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
  // await Firebase.initializeApp(options: getFirebaseOptions());
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
}

Future<DIContainer> _initDependencies() async {
  final diContainer = DIContainer();

  return diContainer;
}

Future<void> _initDotEnv() async {
  await dotenv.load();
  final config = AppEnvironment<AppConfig>.instance().config;
  AppEnvironment.instance().config = config.copyWith(
    url: dotenv.env['API_HOST'],
  );
}
