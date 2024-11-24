import 'package:flutter/widgets.dart';

import '../../../error/error_handler.dart';
import '../../../resources/assets.gen.dart';

extension ErrorExtension on BuildContext {

  String messageFromError(IErrorHandler errorHandler) => errorHandler.when(
        timeout: (_) => 'timeout',
        dio: (_) => 'unexpected_error',
        connection: () => 'no_internet',
        apiError: (error) => error.message,
        apiFields: (errors) {
          if (errors.isNotEmpty) {
            return errors.first.message;
          }
          return 'invalid_data';
        },
        unknown: (_) => 'unexpected_error',
        message: (message) => message,
      );


  Widget imageFromError(IErrorHandler errorHandler) => errorHandler.when(
        timeout: (_) => Assets.icons.arrowLeft.svg(),
        dio: (_) => Assets.icons.arrowLeft.svg(),
        connection: Assets.icons.arrowLeft.svg,
        apiError: (_) => Assets.icons.arrowLeft.svg(),
        apiFields: (_) => Assets.icons.arrowLeft.svg(),
        unknown: (_) => Assets.icons.arrowLeft.svg(),
        message: (_) => Assets.icons.arrowLeft.svg(),
      );
}
