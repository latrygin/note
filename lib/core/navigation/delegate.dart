import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note/core/navigation/transition.dart';
import 'package:note/screen/note/note.dart';
import 'package:note/screen/notes/notes.dart';

import 'navigation.dart';
import 'state.dart';

class TaskRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO>
    implements Nav {
  bool _isHome;

  bool _isTask;

  String? _taskId;

  @override
  final GlobalKey<NavigatorState>? navigatorKey;

  TaskRouterDelegate()
      : _isHome = true,
        _isTask = false,
        navigatorKey = GlobalKey<NavigatorState>();

  bool get isHome => _isHome;

  bool get isTask => _isTask && _taskId != null;

  bool get isCreateTask => _isTask && _taskId == null;

  @override
  void gotoHome() {
    FirebaseAnalytics.instance.logEvent(name: 'goto-home');
    _isTask = false;
    _taskId = null;
    notifyListeners();
  }

  @override
  void gotoTask(String id) {
    FirebaseAnalytics.instance.logEvent(name: 'goto-task');
    _isTask = true;
    _taskId = id;
    notifyListeners();
  }

  @override
  void gotoCreateTask() {
    FirebaseAnalytics.instance.logEvent(name: 'goto-create-task');
    _isTask = true;
    _taskId = null;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (isHome && !isTask && !isCreateTask) {
          _isHome = false;
          _isTask = false;
          _taskId = null;
        }
        if (isTask) {
          _isTask = false;
          _taskId = null;
        }
        if (isCreateTask) {
          _isTask = false;
          _taskId = null;
        }
        notifyListeners();
        return true;
      },
      transitionDelegate: const TaskTransitionDelegate(),
      key: navigatorKey,
      observers: [GetIt.I<RouteObserver>()],
      pages: [
        if (isHome) const MaterialPage(child: NotesPage()),
        if (isCreateTask) const MaterialPage(child: NotePage()),
        if (isTask) MaterialPage(child: NotePage(id: _taskId)),
      ],
    );
  }

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(_isHome, _isTask, _taskId);
  }

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    _taskId = configuration.taskId;
    _isTask = configuration.task;
    _isHome = configuration.home;
    return Future.value();
  }
}
