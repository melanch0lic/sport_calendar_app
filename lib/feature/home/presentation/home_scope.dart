import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_calendart_app/core/utils/extension/src/context_extension.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';

// import '../../localization_control/bloc/localization_control_bloc.dart';
// import '../../localization_control/presentation/localization_scope.dart';
import '../../../runner/dependency_scope.dart';
import '../bloc/home_bloc.dart';

abstract class HomeController {
  void loadEvents();
}

@immutable
class HomeScope extends StatefulWidget {
  final Widget child;

  const HomeScope({required this.child, super.key});

  static HomeController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_HomeScopeInherited>(listen: listen).controller;

  @override
  State<HomeScope> createState() => _HomeScopeState();
}

class _HomeScopeState extends State<HomeScope> implements HomeController {
  late final HomeBloc _homeBloc;
  late final EventBloc _eventBloc;

  @override
  void initState() {
    _homeBloc = DependenciesScope.of(context).resolve<HomeBloc>();
    _eventBloc = DependenciesScope.of(context).resolve<EventBloc>();
    super.initState();
  }

  @override
  void loadEvents() => _eventBloc.add(LoadEvents());

  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (context) => _homeBloc,
        child: BlocProvider<EventBloc>(
          create: (context) => _eventBloc..add(LoadEvents()),
          child: _HomeScopeInherited(controller: this, child: _LocaleListener(child: widget.child)),
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

class _HomeScopeInherited extends InheritedWidget {
  final HomeController controller;
  const _HomeScopeInherited({required this.controller, required super.child});

  @override
  bool updateShouldNotify(_HomeScopeInherited oldWidget) => false;
}
