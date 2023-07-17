import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:note/core/api/client/api_client.dart';
import 'package:note/core/firebase/remote_config.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/core/navigation/parser.dart';
import 'package:note/core/navigation/provider.dart';
import 'package:note/core/navigation/state.dart';
import 'package:note/data/local_datasource/revision_local.dart';
import 'package:note/data/local_datasource/task_local.dart';
import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/data/mock_datasource/revision_remote_mock.dart';
import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/data/remote_datasource/revision_remote.dart';
import 'package:note/data/remote_datasource/task_remote.dart';
import 'package:note/domain/repository/revision_local_impl.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';
import 'package:note/firebase_options.dart';

import 'options.dart';

class DI {
  static Future<void> setUpDI(DIOptions options) async {
    final di = GetIt.instance;
    switch (options) {
      case DIOptions.developer:

        ///Firebase
        await Firebase.initializeApp(
          name: 'production',
          options: DefaultFirebaseOptions.currentPlatform,
        );
        final configRepo = ConfigRepositoryDev();
        di.registerSingleton<ConfigRepositoryDev>(configRepo);

        /// Router delegate
        di.registerSingleton<Nav>(TaskRouterDelegate());
        di.registerSingleton<RouteInformationParser<NavigationStateDTO>>(
          TaskRouteInformationParser(),
        );
        di.registerSingleton<PlatformRouteInformationProvider>(
          DebugRouteInformationProvider(),
        );
        di.registerSingleton<RouteObserver>(RouteObserver());

        /// Repository
        di.registerLazySingleton<TaskLocalDatasource>(TaskLocalMock.new);
        di.registerLazySingleton<TaskRemoteDatasource>(TaskRemoteMock.new);
        di.registerLazySingleton<RevisionLocalDatasource>(
          RevisionLocalMock.new,
        );
        di.registerLazySingleton<RevisionRemoteDatasource>(
          RevisionRemoteMock.new,
        );
        break;
      case DIOptions.production:

        ///Firebase
        await Firebase.initializeApp(
          name: 'production',
          options: DefaultFirebaseOptions.currentPlatform,
        );

        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
        };

        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(
            error,
            stack,
            fatal: true,
          );
          return true;
        };

        /// Router delegate
        di.registerSingleton<FirebaseRemoteConfig>(
          FirebaseRemoteConfig.instance,
        );
        final configRepo = ConfigRepositoryProd(di<FirebaseRemoteConfig>());
        await configRepo.init();
        di.registerSingleton<ConfigRepositoryProd>(configRepo);
        di.registerSingleton<Nav>(TaskRouterDelegate());
        di.registerSingleton<RouteInformationParser<NavigationStateDTO>>(
          TaskRouteInformationParser(),
        );
        di.registerSingleton<PlatformRouteInformationProvider>(
          DebugRouteInformationProvider(),
        );
        di.registerSingleton<RouteObserver>(RouteObserver());

        /// Repository
        di.registerLazySingleton<TaskLocalDatasource>(
          () => TaskLocal(
            device: DeviceInfoPlugin(),
          ),
        );
        di.registerLazySingleton<TaskRemoteDatasource>(
          () => TaskRemote(
            https: ApiClient(),
            revision: RevisionRemote(),
            device: DeviceInfoPlugin(),
          ),
        );
        di.registerLazySingleton<RevisionLocalDatasource>(RevisionLocal.new);
        di.registerLazySingleton<RevisionRemoteDatasource>(RevisionRemote.new);
        break;
    }
  }
}
