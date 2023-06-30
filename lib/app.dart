import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/revision/local_revision_provider_impl.dart';
import 'package:note/domain/provider/revision/revision_provider_impl.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/domain/service/task/task_service_impl.dart';
import 'package:note/utils/l10n/s.dart';
import 'package:note/utils/navigation/navigation.dart';
import 'package:note/utils/navigation/routes.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  final TaskProviderImpl _taskProvider;
  final TaskServiceImpl _taskService;
  final LocalRevisionProviderImpl _localRevisionProvider;
  final RevisionProviderImpl _revisionProvider;
  const App({
    super.key,
    required TaskProviderImpl taskProvider,
    required TaskServiceImpl taskService,
    required LocalRevisionProviderImpl localRevisionProvider,
    required RevisionProviderImpl revisionProvider,
  })  : _taskProvider = taskProvider,
        _taskService = taskService,
        _localRevisionProvider = localRevisionProvider,
        _revisionProvider = revisionProvider;

  static const String _title = 'Note';

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///Local storage for Task
        RepositoryProvider<TaskProviderImpl>(
          create: (context) => _taskProvider,
        ),

        ///Remote storage for Task
        RepositoryProvider<TaskServiceImpl>(
          create: (context) => _taskService,
        ),

        ///Remote storage for Local Revision
        RepositoryProvider<LocalRevisionProviderImpl>(
          create: (context) => _localRevisionProvider,
        ),

        ///Remote storage for Revision
        RepositoryProvider<RevisionProviderImpl>(
          create: (context) => _revisionProvider,
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
