import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:note/domain/mock/task_mock.dart';

import 'app.dart';

void main() {
  runZonedGuarded(
    () {
      runApp(App(taskFacade: TaskMock()));
    },
    (error, stackTrace) => developer.log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
