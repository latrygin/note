import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note/utils/logger/logger.dart';

class DebugRouteInformationProvider extends PlatformRouteInformationProvider {
  DebugRouteInformationProvider()
      : super(
          initialRouteInformation: RouteInformation(
            location: PlatformDispatcher.instance.defaultRouteName,
          ),
        );

  @override
  Future<bool> didPushRoute(String route) {
    logger.d('Platform reports $route');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    logger.d('Platform reports route information: $routeInformation');
    return super.didPushRouteInformation(routeInformation);
  }
}
