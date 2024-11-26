import 'package:l/l.dart';

class DIContainer {
  final Map<Type, _Dependency> _dependencies = {};

  /// Registers a singleton dependency (eager initialization)
  void registerSingleton<T>(T instance) {
    _dependencies[T] = _Dependency(instance: instance);
    l.d('${T.toString()} singleton instance registered');
  }

  /// Registers a factory dependency
  void registerFactory<T>(T Function() factory) {
    _dependencies[T] = _Dependency(factory: factory);
    l.d('${T.toString()} factory registered');
  }

  /// Registers an async factory dependency
  void registerAsync<T>(Future<T> Function() asyncFactory) {
    _dependencies[T] = _Dependency(asyncFactory: asyncFactory);
    l.d('${T.toString()} async factory registered');
  }

  /// Registers a lazy singleton dependency
  void registerLazySingleton<T>(T Function() factory) {
    _dependencies[T] = _Dependency(lazySingletonFactory: factory);
    l.d('${T.toString()} lazy singleton instance registered');
  }

  /// Resolves a dependency
  T resolve<T>() {
    final dependency = _dependencies[T];
    if (dependency == null) {
      throw Exception('Dependency of type $T not found');
    }
    return dependency.getInstance() as T;
  }

  /// Initializes all async dependencies and tracks progress
  Future<void> initializeAllDependencies({
    required void Function(double progress) onProgress,
  }) async {
    final asyncDependencies = _dependencies.entries.where((entry) => entry.value.isAsync).toList();

    final total = asyncDependencies.length;
    var completed = 0;

    for (final entry in asyncDependencies) {
      final type = entry.key;
      final dependency = entry.value;

      try {
        l.d('Initializing $type...');
        await dependency.initializeAsync();
        // _initializedDependencies.add(type);
        completed++;
        l.d('$type initialized successfully.');
      } catch (e) {
        l.d('Error initializing $type: $e');
      } finally {
        onProgress(completed / total);
      }
    }
  }
}

/// Internal helper class to manage dependency lifecycle
class _Dependency<T> {
  final T? instance;
  final T Function()? factory;
  final Future<T> Function()? asyncFactory;
  final T Function()? lazySingletonFactory;

  T? _cachedInstance;

  _Dependency({
    this.instance,
    this.factory,
    this.asyncFactory,
    this.lazySingletonFactory,
  });

  bool get isAsync => asyncFactory != null;

  T getInstance() {
    if (instance != null) return instance!;
    if (factory != null) return factory!();
    if (lazySingletonFactory != null) {
      // Lazy initialization of singleton
      _cachedInstance ??= lazySingletonFactory!();
      return _cachedInstance!;
    }
    throw Exception('Dependency is async and requires initialization');
  }

  Future<void> initializeAsync() async {
    if (_cachedInstance != null || asyncFactory == null) return;
    _cachedInstance = await asyncFactory!();
  }
}
