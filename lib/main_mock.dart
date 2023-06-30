import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/data/local_datasource/revision_local.dart';
import 'package:note/data/local_datasource/task_local.dart';
import 'package:note/data/remote_datasource/revision_remote.dart';
import 'package:note/data/remote_datasource/task_remote.dart';

import 'app.dart';
import 'utils/logger/logger.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        App(
          taskLocalDatasource: TaskLocalDatasource(),
          taskRemoteDatasource: TaskRemoteDatasource(),
          revisionLocalDatasource: RevisionLocalDatasource(),
          revisionRemoteDatasource: RevisionRemoteDatasource(),
        ),
      );
    },
    (error, stackTrace) {
      logger.e('MAIN:', error, stackTrace);
    },
  );
}
