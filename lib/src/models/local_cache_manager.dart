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

  void put<T>(T data) {
    if (exists()) {
      if (enableLogging) {
        log('$cacheKey is already in cache. Skipping put.', name: 'LocalCacheManager');
      }
      return;
    }
    LocalCaching.instance.put(cacheKey, data);
    if (enableLogging) {
      log('$cacheKey is put in cache.', name: 'LocalCacheManager');
    }
  }

  bool exists() {
    return LocalCaching.instance.get(cacheKey) != null;
  }

  Future<void> init() {
   return LocalCaching.instance.init();
  }
}
