import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note/domain/provider/revision/local_revision_provider.dart';
import 'package:note/domain/provider/revision/revision_provider.dart';
import 'package:note/domain/provider/task/task_provider_isar.dart';
import 'package:note/domain/service/task/task_service.dart';
import 'package:note/utils/logger/logger.dart';

import 'app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        App(
          taskProvider: TaskProviderIsar(),
          taskService: TaskService(),
          localRevisionProvider: LocalRevisionProvider(),
          revisionProvider: RevisionProvider(),
        ),
      );
    },
    (error, stackTrace) {
      log(
        error.toString(),
        error: error,
        stackTrace: stackTrace,
      );
      logger.e('main: $error');
    },
  );
}
