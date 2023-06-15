# Мои Дела

Note - это простое и интуитивно понятное приложение Flutter для управления вашими повседневными заметками. Легко записывайте свои мысли, идеи, списки дел и важную информацию с помощью этого удобного приложения для ведения заметок. Проект был сдела в качестве первой части домашнего задания.

<img src="https://github.com/latrygin/note/assets/114460271/d3bfa96e-0a99-4326-8b98-66bf198f9e71" width="100">

## Основные функции

- Отображение списка всех заметок: На главном экране приложения вы увидите список всех созданных заметок. Каждая заметка будет содержать описание, приоритет выполнения и дату создания. Вы также сможете отметить выполненные задачи и удалить ненужные заметки.

- Добавление новой заметки: Чтобы добавить новую заметку, вы можете воспользоваться быстрым созданием (внизу списка) или нажать на FloatingActionButton и перейти к детальному созданию задачи. Здесь вы сможете указать текст заметки, приоритет выполнения и как срок выполнения.

- Редактирование существующей заметки: Если вы выберете заметку из списка на главном экране, вы будете перенаправлены на экран редактирования заметки с предварительно заполненными данными этой заметки. Вы сможете внести изменения в заголовок, приоритет и дату.

## UI Приложения

<img src="https://github.com/latrygin/note/assets/114460271/ef4ce6ba-cbdc-40be-8edd-4d5d157bedbc" width="200">
<img src="https://github.com/latrygin/note/assets/114460271/151fd0c7-fb27-483f-9526-60739f44a37d" width="200">
<img src="https://github.com/latrygin/note/assets/114460271/6a158bb5-1f0a-4914-8110-e52fc4976cf0" width="200">
<img src="https://github.com/latrygin/note/assets/114460271/96a2f889-6926-41c4-b3d0-f5da39928115" width="200">
<img src="https://github.com/latrygin/note/assets/114460271/69231d12-f1fe-4873-aea8-1d38774e99f5" width="200">
<img src="https://github.com/latrygin/note/assets/114460271/0663f9e1-81d0-44fe-acf1-70f701d6342e" width="200">
<img src="https://github.com/latrygin/note/assets/114460271/33b86bbd-c494-4c26-8df0-dd843d035ec0" width="200">

##Зависимости

Для разработки проекта используются следующие зависимости:

```yaml
version: 1.0.0+1

environment:
  sdk: '>=3.0.3 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.2
  equatable: ^2.0.5
  bloc: ^8.1.2
  flutter_bloc: ^8.1.3
  logger: ^1.4.0
  intl: ^0.18.0
```


## Файловая структура

```dart
- domain
  - entity
  - facade
  - mock
  - provider
- screen // Папка экранов
  - note // Экран
    - cubit // Модель экрана
    - view // Главные элементы экрана
    - widget //Дополнительные элементы экрана
  - notes
    - ...
- utils
  - exception
  - l10n
  - logger
  - navigation
  - theme

```
## Установка и запуск проекта

Следуйте этим инструкциям, чтобы установить и запустить проект на вашем локальном компьютере:

1. Клонируйте репозиторий с проектом с помощью следующей команды:

```bash
git clone https://github.com/latrygin/note.git
```

2. Перейдите в каталог проекта:

```bash
cd note
```
3. Запустите следующую команду, чтобы загрузить зависимости проекта:

```bash
flutter pub get
```
4. Подключите свое устройство или эмулятор и выполните следующую команду:

```bash
flutter run
```

## Реализация

### Код разбит на фичи и слои

Пример, модель Task

[lib/domain/entity/task.dart](https://github.com/latrygin/note/blob/main/lib/domain/entity/task.dart)
```dart
class Task {
  int id;
  String text;
  TaskImportant important;
  DateTime? deadline;
  bool done;
  String? color;
  DateTime? createdAt;
  DateTime? changedAt;
  int? lastUpdatedBy;

  Task({
    required this.id,
    required this.text,
    this.important = TaskImportant.basic,
    this.deadline,
    this.done = false,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });
}

```

Пример, интерфейса для работы с Task

[lib/domain/facade/task_facade.dart](https://github.com/latrygin/note/blob/main/lib/domain/facade/task_facade.dart)
```dart
abstract class TaskFacade {
  Future<List<Task>> getAll({FilterTask filter = FilterTask.all});
  Future<Task> getAt(int index);
  Future<void> removeAt(int index);
  Future<void> updateAt({
    required int index,
    String? text,
    TaskImportant? important,
    DateTime? deadline,
    bool? done,
  });
  Future<void> add({
    required String text,
    required TaskImportant important,
    DateTime? deadline,
  });
}
```

и отдельно реализованные классы с моканными данными для будущий класс для работы с локальной базой данных в:

[lib/domain/mock/task_mock.dart](https://github.com/latrygin/note/blob/main/lib/domain/mock/task_mock.dart)

[lib/domain/provider/task_provider.dart](https://github.com/latrygin/note/blob/main/lib/domain/provider/task_provider.dart)

## Логирование

Минимально настроено логирование в файле [lib/utils/logger/logger.dart](https://github.com/latrygin/note/blob/main/lib/utils/logger/logger.dart) , но использовано во всех необходимых местах

```dart
import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printTime: true,
  ),
);
```

Логирование перемещения между экранами:

```dart
class NavigationLogger extends NavigatorObserver {

   @override
    void didPush(
      Route<dynamic> route,
      Route<dynamic>? previousRoute,
    ) {
      logger.i('$NavigationLogger.didPush: ${route.settings.name}');
    }
  
    @override
    void didPop(
      Route<dynamic> route,
      Route<dynamic>? previousRoute,
    ) {
      logger.i('$NavigationLogger.didPop: ${route.settings.name}');
    }
    ...
```

В Cubit:

```dart
  Future<void> initial() async {
    try {
      emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
      final tasks = await _taskFacade.getAll(filter: state.filter);
      emit(NoteSuccessState(tasks: tasks, filter: state.filter));
    } on Object catch (e) {
      logger.e(e); //
      emit(NoteFailureState(e.toString()));
    }
  }

```

И main.dart

```dart
void main() {
  runZonedGuarded(
    () {
      runApp(App(taskFacade: TaskMock()));
    },
    (error, stackTrace) => developer.log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
```

