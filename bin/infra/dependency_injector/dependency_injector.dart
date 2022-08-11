typedef InstanceCreator<T>();

class DependencyInjector {
  DependencyInjector._();
  static final DependencyInjector _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerate<Object>>{};

  /// method to register instance
  void register<T extends Object>(InstanceCreator<T> instace, {bool isSingleton = false}) {
    _instanceMap[T] = _InstanceGenerate(instace, isSingleton);
  }

  /// method to return instance
  T get<T extends Object>() {
    final instance = _instanceMap[T]!.getInstance();
    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception('[ERROR] -> Instance of ${T.toString()} not found');
  }
}

class _InstanceGenerate<T> {
  T? _instance;
  bool _isFirstGet = false;
  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerate(this._instanceCreator, bool _isSingleton) : _isFirstGet = _isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance != null ? _instance : _instanceCreator();
  }
}
