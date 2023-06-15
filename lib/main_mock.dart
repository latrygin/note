import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/domain/mock/task_mock.dart';

import 'app.dart';
import 'utils/logger/logger.dart';

void main() {
  runZonedGuarded(
    () {
      runApp(App(taskFacade: TaskMock()));
    },
    (error, stackTrace) => logger.e(error),
  );
}
