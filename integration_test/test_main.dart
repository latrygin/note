import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note/app.dart';
import 'package:note/core/firebase/remote_config.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/core/navigation/parser.dart';
import 'package:note/core/navigation/provider.dart';
import 'package:note/core/navigation/state.dart';
import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/data/mock_datasource/revision_remote_mock.dart';
import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/domain/repository/revision_local_impl.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';
import 'package:note/firebase_options.dart';

Future<void> main() async {
  final di = GetIt.instance;

  /// Инициализация Binding
  WidgetsFlutterBinding.ensureInitialized();

  ///Firebase
  await Firebase.initializeApp(
    name: 'production',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Инициализация DI
  /// Router delegate
  final configRepo = ConfigRepositoryDev();
  di
    ..registerSingleton<ConfigRepositoryDev>(configRepo)
    ..registerSingleton<Nav>(TaskRouterDelegate())
    ..registerSingleton<RouteInformationParser<NavigationStateDTO>>(
      TaskRouteInformationParser(),
    )
    ..registerSingleton<PlatformRouteInformationProvider>(
      DebugRouteInformationProvider(),
    )
    ..registerSingleton<RouteObserver>(RouteObserver())

    /// Repository
    ..registerLazySingleton<TaskLocalDatasource>(TaskLocalMock.new)
    ..registerLazySingleton<TaskRemoteDatasource>(TaskRemoteMock.new)
    ..registerLazySingleton<RevisionLocalDatasource>(RevisionLocalMock.new)
    ..registerLazySingleton<RevisionRemoteDatasource>(RevisionRemoteMock.new);

  /// Запуск проекта
  runApp(const App());
}
