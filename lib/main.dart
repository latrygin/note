import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/data/local_datasource/revision_local.dart';
import 'package:note/data/local_datasource/task_local.dart';
import 'package:note/data/remote_datasource/revision_remote.dart';
import 'package:note/data/remote_datasource/task_remote.dart';
import 'package:note/utils/logger/logger.dart';

import 'app.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        App(
          taskLocalDatasource: TaskLocal(),
          taskRemoteDatasource: TaskRemote(),
          revisionLocalDatasource: RevisionLocal(),
          revisionRemoteDatasource: RevisionRemote(),
          taskRouterDelegate: TaskRouterDelegate(),
        ),
      );
    },
    (error, stackTrace) {
      logger.e('MAIN:', error, stackTrace);
    },
  );
}
