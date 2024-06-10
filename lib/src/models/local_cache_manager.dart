import 'dart:developer';

import 'package:cached_future_builder/src/caching/local_caching.dart';

class LocalCacheManager {
  final String cacheKey;
  final Duration cacheDuration;
  final bool enableLogging;

  LocalCacheManager({required this.cacheKey, this.cacheDuration = const Duration(days: 1), this.enableLogging = false});
  T? get<T>() {
    final data = LocalCaching.instance.get(cacheKey);
    if (data != null) {
      if (enableLogging) {
        log('$cacheKey is found in cache. Returning cached data.', name: 'LocalCacheManager');
      }
      return data as T;
    }
    log('$cacheKey isn\'t found in cache. Returning null.', name: 'LocalCacheManager');

    return null;
  }

  bool exists() {
    return LocalCaching.instance.get(cacheKey) != null;
  }
  void init() async {
    await LocalCaching.instance.init();
  }
}
