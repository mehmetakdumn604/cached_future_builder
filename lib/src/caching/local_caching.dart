abstract class LocalCaching {
  Future<void> init();
  void put(String key, dynamic value);
  dynamic get(String key);

  T? getAs<T>(String key) {
    final data = get(key);
    if (data != null) {
      return data as T;
    }
    return null;
  }  

  
}
