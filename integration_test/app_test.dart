import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:note/utils/logger/logger.dart';

import 'test_main.dart' as test_app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const titleForTaskCreate = 'New task for test';

  const durationCount = 5;

  const testKeyMaterial = ValueKey('Material');
  const testKeyFloating = ValueKey('Floating');
  const testKeyTextForm = ValueKey('TextForm');
  const testKeyBackButton = ValueKey('BackButton');
  const testKeySaveButton = ValueKey('SaveButton');

  setUp(() => logger.v('Next test is running...'));

  testWidgets('Create task', (tester) async {
    await test_app.main();
    await tester.pumpAndSettle();
    logger.v('Начало теста: Create task');
    await Future<void>.delayed(const Duration(seconds: durationCount));

    logger.v('Нашёл Material');
    expect(find.byKey(testKeyMaterial), findsWidgets);
    await tester.pumpAndSettle();

    logger.v('Ищу testKeyFloating...');
    expect(find.byKey(testKeyFloating), findsWidgets);
    logger
      ..v('Нашёл testKeyFloating')
      ..v('Нажимаю на  testKeyFloating');
    await tester.tap(find.byKey(testKeyFloating));
    await tester.pumpAndSettle();

    logger.v('Жду второй экран...');
    await Future<void>.delayed(const Duration(seconds: durationCount));

    logger.v('Ввожу данные...');
    expect(find.byKey(testKeyTextForm), findsOneWidget);
    await tester.enterText(find.byKey(testKeyTextForm), titleForTaskCreate);
    await tester.pumpAndSettle();
    logger.v('Нажимаю сохранить...');
    await Future<void>.delayed(const Duration(seconds: durationCount));

    expect(find.byKey(testKeySaveButton), findsOneWidget);
    await tester.tap(find.byKey(testKeySaveButton));
    await tester.pumpAndSettle();

    logger.v('Нажимаю на кнопку назад...');
    await Future<void>.delayed(const Duration(seconds: durationCount));

    expect(find.byKey(testKeyBackButton), findsOneWidget);
    await tester.tap(find.byKey(testKeyBackButton));
    await tester.pumpAndSettle();

    await Future<void>.delayed(const Duration(seconds: durationCount));

    logger.v('Ищу текст...');
    expect(find.text(titleForTaskCreate, findRichText: true), findsWidgets);

    logger.v('Конец теста');
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: durationCount));
  });
}
