import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note/core/api/client/api_client.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/data/local_datasource/revision_local.dart';
import 'package:note/data/local_datasource/task_local.dart';
import 'package:note/data/remote_datasource/revision_remote.dart';
import 'package:note/data/remote_datasource/task_remote.dart';
import 'package:note/firebase_options.dart';
import 'package:note/utils/logger/logger.dart';

import 'app.dart';

Future<void> main() async {
  /// Инициализация Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    logger.d('Caught error in FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.d('Caught error in PlatformDispatcher.onError');
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };

  /// Запуск проекта
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
}
