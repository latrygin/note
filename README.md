# Мои Дела

Note - это простое и интуитивно понятное приложение Flutter для управления вашими повседневными заметками. Легко записывайте свои мысли, идеи, списки дел и важную информацию с помощью этого удобного приложения для ведения заметок. Проект был сдела в качестве первой части домашнего задания.

<img src="https://github.com/latrygin/note/assets/114460271/d3bfa96e-0a99-4326-8b98-66bf198f9e71" width="100">


## Связаться со мной, чтобы обсудить критерии оценивания

[Telegram](https://t.me/alatrygin)

## Скачать приложение

[download APK](https://github.com/latrygin/note/releases/download/latest/note.apk)


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


## Зависимости

Для разработки проекта используются следующие зависимости:

```yaml

version: 2.0.0+2

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
  dio: ^5.2.0
  shared_preferences: ^2.1.2
  uuid: ^3.0.7
  device_info_plus: ^9.0.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0
  build_runner: ^2.4.5
  hive_generator: ^2.0.0

```


## Файловая структура

```dart
- domain
  - api // Dio, интерсепторы, apiClient
  - entity
  - service //Контроллер для работы с сервером
  - provider //Контроллер для работы с локальным хранилищем
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

3. Создать два файла:

```bash
touch lib/domain/api/client/token.dart
```

token.dart

```dart
abstract class Token {
  static const String _token = 'your_token';

  static String get token => _token;
}
```

```bash
touch lib/domain/api/client/url.dart
```

url.dart

```dart
abstract class URLs {
  static const String getAll = 'https://[path]/list';
  static const String patch = 'https://[path]/list';
  static const String post = 'https://[path]/list';
  static String get(String id) {
    return 'https://[path]/list/$id';
  }

  static String delete(String id) {
    return 'https://[path]/list/$id';
  }

  static String put(String id) {
    return 'https://[path]/list/$id';
  }
}

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

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final TaskImportant importance;

  @HiveField(3)
  final DateTime? deadline;

  @HiveField(4)
  final bool done;

  @HiveField(5)
  final String? color;

  @HiveField(6)
  final DateTime? createdAt;

  @HiveField(7)
  final DateTime? changedAt;

  @HiveField(8)
  final String? lastUpdatedBy;


  Task({
    required this.id,
    required this.text,
    this.importance = TaskImportant.basic,
    this.deadline,
    this.done = false,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });


```

### Пример, интерфейса для работы с local storage

```dart
import 'package:note/domain/entity/task.dart';

abstract class TaskProviderImpl {
  Future<List<Task>> getAll();
  Future<Task> getAt(String id);
  Future<Task> updateAt(Task task);
  Future<void> removeAt(String id);
  Future<Task> create(Task task);
  Future<List<Task>> patch(List<Task> tasks);
}

```

### Пример, интерфейса для работы с remote storage

```dart
import 'package:note/domain/entity/task.dart';

abstract class TaskServiceImpl {
  Future<TaskListResponse> getAll();
  Future<TaskResponse> get(String id);
  Future<TaskResponse> put(Task request);
  Future<TaskResponse> delete(String id);
  Future<TaskResponse> post(Task request);
  Future<TaskListResponse> patch(TaskListRequest request);
}
```

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

В API:

```dart
  Future<Response<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      logger
        ..v('POST: $path')
        ..v(data);
      final response = await _https.post<Map<String, dynamic>>(
        path,
        data: data,
      );

      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

```

И main.dart

```dart
import 'app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      runApp(
        App(
          taskProvider: TaskProvider(),
          taskService: TaskService(),
          localRevisionProvider: LocalRevisionProvider(),
          revisionProvider: RevisionProvider(),
        ),
      );
    },
    (error, stackTrace) {
      log(
        error.toString(),
        error: error,
        stackTrace: stackTrace,
      );
      logger.e('main: $error');
    },
  );
}


```

