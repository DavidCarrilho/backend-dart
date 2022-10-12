typedef InstanceCreator<T> = T Function();

class DependencyInjector {
  DependencyInjector._();
  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  /// method to register instance
  void register<T extends Object>(InstanceCreator<T> instance, {bool isSingleton = true}) {
    _instanceMap[T] = _InstanceGenerator(instance, isSingleton);
  }

  /// method to return instance
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception('[ERROR] -> Instance of ${T.toString()} not found');
  }
  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;
  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerator(this._instanceCreator, bool _isSingleton) : _isFirstGet = _isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance ?? _instanceCreator();
  }
}
