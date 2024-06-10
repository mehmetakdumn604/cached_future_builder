import 'package:hive_flutter/hive_flutter.dart';

class LocalCaching {
  static final LocalCaching _instance = LocalCaching._init();

  static LocalCaching get instance => _instance;
  LocalCaching._init();

  Box? _box;

  bool isInitialized = false;
  Future<void> init() async {
    if (isInitialized) {
      return;
    }
    await Hive.initFlutter();
    _box = await Hive.openBox('local_cache');
    isInitialized = true;
  }

  void put(String key, dynamic value) {
    _box?.put(key, value);
  }

  dynamic get(String key) {
    return _box?.get(key);
  }
}
