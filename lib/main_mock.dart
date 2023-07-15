import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/data/mock_datasource/revision_remote_mock.dart';
import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/firebase_options.dart';
import 'package:note/utils/logger/logger.dart';

import 'app.dart';

Future<void> main() async {
  /// Инициализация Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Инициализация Firebase
  await Firebase.initializeApp(
    name: 'main_mock',
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
}
