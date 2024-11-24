import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_calendart_app/core/modules/auth/token_storage.dart';
import 'package:sport_calendart_app/core/modules/dio_module.dart';
import 'package:sport_calendart_app/core/services/di_container/di_container.dart';
import 'package:sport_calendart_app/feature/auth/data/auth_api.dart';
import 'package:sport_calendart_app/feature/auth/data/bloc/bloc/auth_bloc.dart';
import 'package:sport_calendart_app/feature/auth/data/datasources/auth_datasource.dart';
import 'package:sport_calendart_app/feature/auth/data/datasources/token_storage_sp.dart';
import 'package:sport_calendart_app/feature/auth/data/repositories/auth_repository_implementation.dart';
import 'package:sport_calendart_app/feature/notification/data/repositories/notification_repository_implementation.dart';
import 'package:sport_calendart_app/firebase_options.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

import '../core/environment/app_environment.dart';
import '../core/router/app_router.dart';
import '../core/router/routes_enum.dart';
import '../core/splash_util/splash_util.dart';
import '../feature/app/app.dart';
import '../feature/auth/logic/auth_interceptor.dart';
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
        await _initDotEnv();
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

  final TokenStorage<Token> tokenStorage = TokenStorageSP(sharedPreferences: prefs);
  final isLogged = await tokenStorage.hasToken();

  final GoRouter router = AppRouter(initialLocation: isLogged ? HomeRoutes.home.path : AuthRoutes.signIn.path).router;

  diContainer.registerSingleton<GoRouter>(router);

  final DioModule dioModule = DioModule();

  final AuthApi authApi = AuthApi(dioModule.dio);

  final AuthDataSource dataSource = AuthDataSourceNetwork(authApi);
  final AuthRepository authRepository = AuthRepositoryImpl(dataSource: dataSource, storage: tokenStorage);

  final TokenInterceptor authInterceptor = TokenInterceptor(sessionData: tokenStorage, authApi: authApi);
  dioModule.dio.interceptors.add(authInterceptor);

  diContainer.registerSingleton<DioModule>(dioModule);
  diContainer.registerSingleton<NotificationRepository>(NotificationRepositoryImplementation(firebaseMessaging, prefs));
  diContainer.registerSingleton<AuthBloc>(AuthBloc(authRepository: authRepository));

  return diContainer;
}

Future<void> _initDotEnv() async {
  await dotenv.load();
  final config = AppEnvironment<AppConfig>.instance().config;
  AppEnvironment.instance().config = config.copyWith(
    url: dotenv.env['API_HOST'],
  );
}
