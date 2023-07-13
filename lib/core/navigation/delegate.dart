import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/navigation/transition.dart';
import 'package:note/screen/note/note.dart';
import 'package:note/screen/notes/notes.dart';

import 'state.dart';

class TaskRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO> {
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

  void gotoHome() {
    _isTask = false;
    _taskId = null;
    notifyListeners();
  }

  void gotoTask(String id) {
    _isTask = true;
    _taskId = id;
    notifyListeners();
  }

  void gotoCreateTask() {
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
      observers: [
        context.read<RouteObserver>(),
      ],
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
