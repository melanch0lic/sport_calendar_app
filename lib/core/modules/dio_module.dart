import 'package:dio/dio.dart';

import '../app_connect/app_connect.dart';
import '../environment/app_environment.dart';

class DioModule {
  static DioModule? _instance;

  final Dio dio;

  DioModule._internal()
      : dio = Dio(
          BaseOptions(
            baseUrl: AppEnvironment<AppConfig>.instance().config.url,
            receiveTimeout: const Duration(seconds: 35),
          ),
        ) {
    dio.interceptors.addAll([LogInterceptor(requestBody: true, responseBody: true)]);

    const appConnect = AppConnect();
    final connectInterceptor = ConnectInterceptor(appConnect: appConnect);
    dio.interceptors.add(connectInterceptor);
  }

  factory DioModule() {
    return _instance ??= DioModule._internal();
  }
}
