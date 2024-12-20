import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_calendart_app/feature/auth/presentation/auth_scope.dart';
import 'package:sport_calendart_app/feature/notification/presentation/notification_scope.dart';
import 'package:sport_calendart_app/runner/dependency_scope.dart';

import '../../core/theme/app_theme.dart';

class StreakerApp extends StatelessWidget {
  const StreakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MaterialApp();
  }
}

class _MaterialApp extends StatefulWidget {
  const _MaterialApp();

  @override
  State<_MaterialApp> createState() => _MaterialAppState();
}

class _MaterialAppState extends State<_MaterialApp> {
  @override
  Widget build(BuildContext context) {
    return NotificationScope(
      child: AuthScope(
        child: MaterialApp.router(
          locale: const Locale('ru'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('ru'),
            Locale('en'),
          ],

          // locale: LocalizationScope.localeOf(context),
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: DependenciesScope.of(context).resolve<GoRouter>(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightThemeData,
          builder: (context, child) => _MediaQuery(
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

@immutable
class _MediaQuery extends StatelessWidget {
  final Widget child;
  const _MediaQuery({required this.child});

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: child,
      );
}
