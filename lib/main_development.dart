import 'package:flutter/material.dart';
import 'package:note/core/di/di.dart';
import 'package:note/core/di/options.dart';
import 'package:note/utils/logger/logger.dart';
import 'app.dart';

Future<void> main() async {
  logger.i('Start main_development');

  /// Инициализация Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Инициализация DI
  await DI.setUpDI(DIOptions.developer);

  /// Запуск проекта
  runApp(const App());
}
