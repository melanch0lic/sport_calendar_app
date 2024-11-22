import 'dart:async';

class DIContainer {
  final Map<Type, _Dependency> _dependencies = {};
  final List<Type> _initializedDependencies = [];

  /// Registers a singleton dependency
  void registerSingleton<T>(T instance) {
    _dependencies[T] = _Dependency(instance: instance);
  }

  /// Registers a factory dependency
  void registerFactory<T>(T Function() factory) {
    _dependencies[T] = _Dependency(factory: factory);
  }

  /// Registers an async factory dependency
  void registerAsync<T>(Future<T> Function() asyncFactory) {
    _dependencies[T] = _Dependency(asyncFactory: asyncFactory);
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
    required void Function(String message) logger,
    required void Function(double progress) onProgress,
  }) async {
    final asyncDependencies = _dependencies.entries.where((entry) => entry.value.isAsync).toList();

    final total = asyncDependencies.length;
    var completed = 0;

    for (final entry in asyncDependencies) {
      final type = entry.key;
      final dependency = entry.value;

      try {
        logger('Initializing $type...');
        await dependency.initializeAsync();
        _initializedDependencies.add(type);
        completed++;
        logger('$type initialized successfully.');
      } catch (e) {
        logger('Error initializing $type: $e');
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
  T? _cachedInstance;

  _Dependency({this.instance, this.factory, this.asyncFactory});

  bool get isAsync => asyncFactory != null;

  T getInstance() {
    if (instance != null) return instance!;
    if (factory != null) {
      return factory!();
    }
    throw Exception('Dependency is async and requires initialization');
  }

  Future<void> initializeAsync() async {
    if (_cachedInstance != null || asyncFactory == null) return;
    _cachedInstance = await asyncFactory!();
  }
}
