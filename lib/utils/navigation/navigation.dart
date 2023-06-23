import 'package:flutter/material.dart';

import 'observer.dart';
import 'routes.dart';

class NavigationManager {
  NavigationManager._();

  static final instance = NavigationManager._();

  final key = GlobalKey<NavigatorState>();
  final routeAwareObserver = RouteObserver();

  late final observers = <NavigatorObserver>[
    NavigationLogger(),
    routeAwareObserver,
  ];

  NavigatorState get _navigator => key.currentState!;

  void openTask(String? id) {
    _navigator.pushNamed(
      RouteNames.note,
      arguments: id,
    );
  }

  void maybePop<T extends Object>([T? result]) {
    _navigator.maybePop(result);
  }

  void pop() {
    _navigator.pop();
  }

  void popToHome() {
    _navigator.popUntil(ModalRoute.withName(RouteNames.notes));
  }
}
