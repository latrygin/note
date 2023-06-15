import 'package:flutter/widgets.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    //logger.i('$NavigationLogger.didPush: ${route.settings.name}');
  }

  @override
  void didPop(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    //logger.i('$NavigationLogger.didPop: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {}

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {}

  @override
  void didReplace({
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  }) {}

  @override
  void didRemove(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {}
}
