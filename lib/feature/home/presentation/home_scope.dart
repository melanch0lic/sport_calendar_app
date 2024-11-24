import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';

// import '../../localization_control/bloc/localization_control_bloc.dart';
// import '../../localization_control/presentation/localization_scope.dart';
import '../../../runner/dependency_scope.dart';
import '../bloc/home_bloc.dart';
import '../domain/repositories/event_repository.dart';

@immutable
class HomeScope extends StatelessWidget {
  final Widget child;

  const HomeScope({required this.child, super.key});

  static void readOf(BuildContext context) {
    // final locale = LocalizationScope.getLocaleCode(context, listen: false);
    // context.read<HomeBloc>().add(HomeEvent.read(locale: locale));
  }

  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: BlocProvider<EventBloc>(
          create: (context) => EventBloc(DependenciesScope.of(context).resolve<EventRepository>())..add(LoadEvents()),
          child: _LocaleListener(child: child),
        ),
      );
}

class _LocaleListener extends StatelessWidget {
  final Widget child;
  const _LocaleListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
    // BlocListener<LocalizationControlBloc, LocalizationControlState>(
    // listener: (context, state) => HomeScope.readOf(context),
    // child: child,
    // );
  }
}
