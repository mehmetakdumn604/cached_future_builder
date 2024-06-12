import 'dart:developer';

import 'package:cached_future_builder/src/caching/local_caching.dart';

class LocalCacheManager<K extends LocalCaching> {
  final String cacheKey;
  final Duration cacheDuration;
  final bool enableLogging;
  final K localCaching;

  LocalCacheManager({required this.cacheKey, this.cacheDuration = const Duration(days: 1), this.enableLogging = false, required this.localCaching});
  T? get<T>() {
    final data = localCaching.getAs<T>(cacheKey);
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
    localCaching.put(cacheKey, data);
    if (enableLogging) {
      log('$cacheKey is put in cache.', name: 'LocalCacheManager');
    }
  }

  bool exists() {
    return localCaching.get(cacheKey) != null;
  }

  Future<void> init() {
    return localCaching.init();
  }
}
