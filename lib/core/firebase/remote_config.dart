import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRepositoryProd {
  final FirebaseRemoteConfig _remoteConfig;

  ConfigRepositoryProd(this._remoteConfig);

  String get useMyColor => _remoteConfig.getString('color');

  Future<void> init() async {
    await _remoteConfig.setDefaults({
      'color': '0xFFF44336',
    });
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 2),
        minimumFetchInterval: const Duration(seconds: 2),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }
}

class ConfigRepositoryDev {
  ConfigRepositoryDev();

  String get useMyColor => '0xFFF44336';

  Future<void> init() async {}
}
