import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final _loggerNoStack = Logger(
    filter: _LogFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
    output: MultiOutput([DeveloperConsoleOutput()]),
  );

  final _logger = Logger(
    filter: _LogFilter(),
    printer: PrefixPrinter(PrettyPrinter(
      methodCount: 1,
      printTime: false,
    )),
    output: MultiOutput([DeveloperConsoleOutput()]),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _loggerNoStack.log(Level.error, 'ERROR: ${err.message}');
    throw err;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final base = response.requestOptions;
    final headers = base.headers.entries.map((el) => '${el.key} : ${el.value}').join('\n');
    var level = Level.info;
    if ((response.statusCode ?? 0) >= 400) {
      level = Level.warning;
    } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
      level = Level.error;
    }
    _loggerNoStack.log(level, 'RESPONSE <- ${response.statusCode} ${base.method} ${base.uri}\n$headers');
    if (response.data != null) {
      _logger.log(Level.trace, response.data);
    }
    _loggerNoStack.log(level, 'RESPONSE END');
    handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final headers = options.headers.entries.map((el) => '${el.key} : ${el.value}').join('\n');
      _loggerNoStack.i('REQUEST -> ${options.method} ${options.uri}\n$headers\n');
      if (options.data != null) {
        _logger.log(Level.trace, options.data);
      }
      _loggerNoStack.i('REQUEST END');
    } catch (error) {
      _loggerNoStack.e(error);
    }

    super.onRequest(options, handler);
  }
}

class _LogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

class DeveloperConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final StringBuffer buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}

class IosConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(stderr.writeln);
  }
}
