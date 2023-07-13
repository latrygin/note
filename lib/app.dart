import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/core/navigation/parser.dart';
import 'package:note/core/navigation/provider.dart';
import 'package:note/domain/repository/revision_local_impl.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';
import 'package:provider/provider.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  final TaskLocalDatasource _taskLocalDatasource;
  final TaskRemoteDatasource _taskRemoteDatasource;
  final RevisionLocalDatasource _revisionLocalDatasource;
  final RevisionRemoteDatasource _revisionRemoteDatasource;
  final TaskRouterDelegate _taskRouterDelegate;

  const App({
    super.key,
    required TaskLocalDatasource taskLocalDatasource,
    required TaskRemoteDatasource taskRemoteDatasource,
    required RevisionLocalDatasource revisionLocalDatasource,
    required RevisionRemoteDatasource revisionRemoteDatasource,
    required TaskRouterDelegate taskRouterDelegate,
  })  : _taskLocalDatasource = taskLocalDatasource,
        _taskRemoteDatasource = taskRemoteDatasource,
        _revisionLocalDatasource = revisionLocalDatasource,
        _revisionRemoteDatasource = revisionRemoteDatasource,
        _taskRouterDelegate = taskRouterDelegate;

  static const String _title = 'Note';

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///Local storage for Task
        RepositoryProvider<TaskLocalDatasource>.value(
          value: _taskLocalDatasource,
        ),

        ///Remote storage for Task
        RepositoryProvider<TaskRemoteDatasource>.value(
          value: _taskRemoteDatasource,
        ),

        ///Remote storage for Local Revision
        RepositoryProvider<RevisionLocalDatasource>.value(
          value: _revisionLocalDatasource,
        ),

        ///Remote storage for Revision
        RepositoryProvider<RevisionRemoteDatasource>.value(
          value: _revisionRemoteDatasource,
        ),

        ChangeNotifierProvider<TaskRouterDelegate>.value(
          value: _taskRouterDelegate,
        ),

        Provider<RouteObserver>.value(
          value: RouteObserver(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            key: const ValueKey('Material'),
            title: _title,

            ///localizations
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,

            ///theme
            theme: FlutterTheme.light,
            darkTheme: FlutterTheme.dark,

            ///Navigation
            routerDelegate: context.read<TaskRouterDelegate>(),
            routeInformationParser: TaskRouteInformationParser(),
            routeInformationProvider: DebugRouteInformationProvider(),

            ///Other
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
