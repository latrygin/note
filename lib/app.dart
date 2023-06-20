import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/utils/l10n/s.dart';
import 'package:note/utils/navigation/navigation.dart';
import 'package:note/utils/navigation/routes.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  final TaskProviderImpl taskFacade;
  const App({super.key, required this.taskFacade});

  static const String title = 'Note';

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: taskFacade,
      child: MaterialApp(
        title: title,

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
