import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
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
  final GoRouter _router = AppRouter().router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // locale: LocalizationScope.localeOf(context),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      builder: (context, child) => _MediaQuery(
        child: child ?? const SizedBox.shrink(),
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
