import 'package:cached_future_builder/cached_future_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CachedFutureBuilder(
        onData: (data) {
          return Center(
            child: Text(data.toString()),
          );
        },
        future: Future.value("Hello CachedFutureBuilder"),
        onWaiting: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        onError: (error) {
          return Center(
            child: Text(error.toString()),
          );
        },
        onNoData: () {
          return const Center(
            child: Text("No data"),
          );
        },
        cacheManager: LocalCacheManager(
          cacheKey: "cachedfuturebuilder",
          enableLogging: true,
          cacheDuration: const Duration(days: 1),
          localCaching: LocalManager(),
        ),
      ),
    );
  }
}

class LocalManager extends LocalCaching {
  @override
  get(String key) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  void put(String key, value) {
    // TODO: implement put
  }
}
