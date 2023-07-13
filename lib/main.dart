import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:note/core/api/client/api_client.dart';
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
          taskLocalDatasource: TaskLocal(
            device: DeviceInfoPlugin(),
          ),
          taskRemoteDatasource: TaskRemote(
            https: ApiClient(),
            revision: RevisionRemote(),
            device: DeviceInfoPlugin(),
          ),
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
