import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/core/navigation/state.dart';
import 'package:note/utils/theme/theme.dart';


class App extends StatelessWidget {
  const App({super.key});

  static const String _title = 'Note';

  @override
  Widget build(BuildContext context) {
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
      routerDelegate: GetIt.I<Nav>() as TaskRouterDelegate,
      routeInformationParser: GetIt.I<RouteInformationParser<NavigationStateDTO>>(),
      routeInformationProvider: GetIt.I<PlatformRouteInformationProvider>(),

      ///Other
      debugShowCheckedModeBanner: false,
    );
  }
}
