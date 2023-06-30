import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/domain/provider/revision/local_revision_provider.dart';
import 'package:note/domain/provider/revision/revision_provider.dart';
import 'package:note/domain/provider/task/task_provider_isar.dart';
import 'package:note/domain/service/task/task_service.dart';

import 'app.dart';
import 'utils/logger/logger.dart';

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
    (error, stackTrace) => logger.e(error),
  );
}
