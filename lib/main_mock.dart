import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/data/mock_datasource/revision_remote_mock.dart';
import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/utils/logger/logger.dart';

import 'app.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        App(
          taskLocalDatasource: TaskLocalMock(),
          taskRemoteDatasource: TaskRemoteMock(),
          revisionLocalDatasource: RevisionLocalMock(),
          revisionRemoteDatasource: RevisionRemoteMock(),
          taskRouterDelegate: TaskRouterDelegate(),
        ),
      );
    },
    (error, stackTrace) {
      logger.e('MAIN:', error, stackTrace);
    },
  );
}
