import 'package:flutter/material.dart';
import 'package:note/screen/note/note.dart';
import 'package:note/screen/notes/notes.dart';

abstract class RouteNames {
  const RouteNames._();

  static const initialRoute = notes;

  static const notes = '/';
  static const note = '/note';
}

abstract class RoutesBuilder {
  const RoutesBuilder._();

  static final routes = <String, Widget Function(BuildContext)>{
    RouteNames.notes: (_) => const NotesPage(),
    RouteNames.note: (context) => NotePage(
          id: ModalRoute.of(context)?.settings.arguments as int?,
        ),
  };

  static Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.notes:
        return MaterialPageRoute(
          builder: (_) => const NotesPage(),
          settings: settings,
        );

      case RouteNames.note:
        return MaterialPageRoute<int?>(
          builder: (_) =>  NotePage(id: settings.arguments as int?,),
          settings: settings,
        );
    }
    return null;
  }
}
