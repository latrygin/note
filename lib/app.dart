import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/core/navigation/routes.dart';
import 'package:note/domain/repository/revision_local_impl.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  final TaskLocalDatasourceImpl _taskLocalDatasource;
  final TaskRemoteDatasourceImpl _taskRemoteDatasource;
  final RevisionLocalDatasourceImpl _revisionLocalDatasource;
  final RevisionRemoteDatasourceImpl _revisionRemoteDatasource;

  const App({
    super.key,
    required TaskLocalDatasourceImpl taskLocalDatasource,
    required TaskRemoteDatasourceImpl taskRemoteDatasource,
    required RevisionLocalDatasourceImpl revisionLocalDatasource,
    required RevisionRemoteDatasourceImpl revisionRemoteDatasource,
  })  : _taskLocalDatasource = taskLocalDatasource,
        _taskRemoteDatasource = taskRemoteDatasource,
        _revisionLocalDatasource = revisionLocalDatasource,
        _revisionRemoteDatasource = revisionRemoteDatasource;

  static const String _title = 'Note';

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///Local storage for Task
        RepositoryProvider<TaskLocalDatasourceImpl>(
          create: (context) => _taskLocalDatasource,
        ),

        ///Remote storage for Task
        RepositoryProvider<TaskRemoteDatasourceImpl>(
          create: (context) => _taskRemoteDatasource,
        ),

        ///Remote storage for Local Revision
        RepositoryProvider<RevisionLocalDatasourceImpl>(
          create: (context) => _revisionLocalDatasource,
        ),

        ///Remote storage for Revision
        RepositoryProvider<RevisionRemoteDatasourceImpl>(
          create: (context) => _revisionRemoteDatasource,
        ),
      ],
      child: MaterialApp(
        title: _title,

        ///localizations
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,

        ///theme
        theme: FlutterTheme.light,
        //darkTheme: FlutterTheme.dark,

        ///Navigation
        navigatorKey: NavigationManager.instance.key,
        initialRoute: RouteNames.initialRoute,
        onGenerateRoute: RoutesBuilder.onGenerateRoute,
        navigatorObservers: NavigationManager.instance.observers,

        ///Other
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
