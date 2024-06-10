import 'dart:developer';

import 'package:cached_future_builder/cached_future_builder.dart';
import 'package:cached_future_builder/src/models/local_cache_manager.dart';
import 'package:flutter/material.dart';

class CachedFutureBuilder<T> extends StatefulWidget {
  const CachedFutureBuilder({super.key, this.future, required this.onData, this.onWaiting, this.onError, this.onNoData, this.cacheManager});
  final Future<T?>? future;
  final Widget Function(T?) onData;
  final Widget Function()? onWaiting;
  final Widget Function(Object?)? onError;
  final Widget Function()? onNoData;

  final LocalCacheManager? cacheManager;

  @override
  State<CachedFutureBuilder<T>> createState() => _CachedFutureBuilderState<T>();
}

class _CachedFutureBuilderState<T> extends State<CachedFutureBuilder<T>> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.cacheManager?.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.cacheManager != null && (widget.cacheManager?.exists() ?? false)
        ? widget.onData(widget.cacheManager?.get())
        : FutureBuilder(
            future: widget.future,
            builder: (context, AsyncSnapshot<T?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return widget.onWaiting?.call() ?? const Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.hasError) {
                return widget.onError?.call(snapshot.error) ?? Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.hasData && snapshot.data != null) {
                return widget.onData(snapshot.data);
              }
              return widget.onNoData?.call() ?? const Center(child: Text("No data"));
            });
  }

  @override
  bool get wantKeepAlive => true;
}
