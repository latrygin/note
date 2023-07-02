import 'package:flutter/widgets.dart';
import 'package:note/core/navigation/state.dart';

import 'paths.dart';

class TaskRouteInformationParser
    extends RouteInformationParser<NavigationStateDTO> {
  @override
  Future<NavigationStateDTO> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return Future.value(NavigationStateDTO.home());
    }
    if (uri.pathSegments.isNotEmpty) {
      switch (uri.pathSegments[0]) {
        case Paths.task:
          if (uri.pathSegments.length == 1) {
            return Future.value(NavigationStateDTO.taskCreate());
          } else {
            return Future.value(NavigationStateDTO.task(uri.pathSegments[1]));
          }
        default:
          return Future.value(NavigationStateDTO.home());
      }
    } else {
      return Future.value(NavigationStateDTO.home());
    }
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationStateDTO configuration) {
    if (configuration.home) {
      return const RouteInformation(location: Paths.tasks);
    }
    if (configuration.taskId == null) {
      return const RouteInformation(location: '/${Paths.task}');
    }
    return RouteInformation(location: '/${Paths.task}/${configuration.taskId}');
  }
}
