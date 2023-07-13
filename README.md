# Мои Дела

Note - это простое и интуитивно понятное приложение Flutter для управления вашими повседневными заметками. Легко записывайте свои мысли, идеи, списки дел и важную информацию с помощью этого удобного приложения для ведения заметок. Проект был сдела в качестве первой части домашнего задания.

<img src="https://github.com/latrygin/note/assets/114460271/e1dd5830-9035-4160-932e-48330e31d855" width="100">



## Связаться со мной, чтобы обсудить критерии оценивания

[Telegram](https://t.me/alatrygin)

## Скачать приложение

[Скачать APK](https://github.com/latrygin/note/releases/download/latest/note.apk)


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
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.0.15
  provider: ^6.0.5

dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0
  build_runner: ^2.4.5
  isar_generator: ^3.1.0+1
  test: ^1.24.1
  bloc_test: ^9.1.3
```


## Файловая структура

```dart
- core
  - api                // Dio, интерсепторы, apiClient
  - exception          // Исключения прилоложения
  - l10n               // Локализация приложения
  - navigation         // Навигация 2.0

- data
  - local_datasource   // Данные из локального хранилища
  - remote_datasource  // Данные из сервера
  - mock_datasource    // Моканые данные

- domain
  - entity             // Сущности проекта
  - repository         // Интерфейсы для работы с [data]
  
- screen               // Папка экранов
  - note               // Экран
    - cubit            // Модель экрана
    - view             // Главные элементы экрана
    - widget           // Дополнительные элементы экрана
  - notes
    - ...

- utils
  - logger             // Логирование приложения
  - theme              // Тема приложения

- app.dart             // app файл с мультирепозиторием
- main.dart            // main запуск приложения с реальными данными
- main_mock.dart       // main_mock запуск с мокаными данными

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

3. Подключите свое устройство или эмулятор и выполните следующую команду:

```bash
flutter run --dart-define=TOKEN=YOUR_TOKEN --dart-define=PATH=YOUR_PATH
```

## Реализация

### Код разбит на фичи и слои

Пример, модель Task

[lib/domain/entity/task.dart](https://github.com/latrygin/note/blob/main/lib/domain/entity/task.dart)
```dart

@collection
class Task {
  Id get isarId => fastHash(id);

  final String id;

  final String text;

  @enumerated
  final TaskImportant importance;

  final DateTime? deadline;

  final bool done;

  final String? color;

  final DateTime? createdAt;

  final DateTime? changedAt;

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
}
```

### Пример, интерфейса для работы с local storage

```dart
abstract class TaskLocalDatasource {
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
abstract class TaskRemoteDatasource {
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

Логирование для работы с API:

```dart
class ApiClient {

   Future<Response<Map<String, dynamic>>> get(String path) async {
    try {
      logger.v('GET: $path');
      final response = await _https.get<Map<String, dynamic>>(path);
      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

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
    ...
```

И main.dart

```dart
import 'app.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        App(
          taskLocalDatasource: TaskLocal(),
          taskRemoteDatasource: TaskRemote(),
          revisionLocalDatasource: RevisionLocal(),
          revisionRemoteDatasource: RevisionRemote(),
          taskRouterDelegate: TaskRouterDelegate(),
        ),
      );
    },
    (error, stackTrace) {
      logger.e('MAIN:', error, stackTrace);
    },
  );
}
```

## Тестирование

Протестированы все сущности от работы с репозиторием, до работы со стейт менеджером внутри экрана, успешную работу тестов можно увидеть в GitHub Actions

<img width="945" alt="Снимок экрана 2023-07-05 в 15 22 03" src="https://github.com/latrygin/note/assets/114460271/5f6afb56-8355-44f9-b474-9628859612bc">

В GitHub Actions так же проходит тест интеграционный с проходом по задачи, создать заметки, сохранить, выйти и найти по тексту с мокаными данными

## DI

DI релирован с помощью пакета flutter_bloc и определяет сущности на старте проекта:

```dart
class App extends StatelessWidget {
  final TaskLocalDatasource _taskLocalDatasource;
  final TaskRemoteDatasource _taskRemoteDatasource;
  final RevisionLocalDatasource _revisionLocalDatasource;
  final RevisionRemoteDatasource _revisionRemoteDatasource;
  final TaskRouterDelegate _taskRouterDelegate;

  const App({
    super.key,
    required TaskLocalDatasource taskLocalDatasource,
    required TaskRemoteDatasource taskRemoteDatasource,
    required RevisionLocalDatasource revisionLocalDatasource,
    required RevisionRemoteDatasource revisionRemoteDatasource,
    required TaskRouterDelegate taskRouterDelegate,
  })  : _taskLocalDatasource = taskLocalDatasource,
        _taskRemoteDatasource = taskRemoteDatasource,
        _revisionLocalDatasource = revisionLocalDatasource,
        _revisionRemoteDatasource = revisionRemoteDatasource,
        _taskRouterDelegate = taskRouterDelegate;

  static const String _title = 'Note';

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///Local storage for Task
        RepositoryProvider<TaskLocalDatasource>.value(
          value: _taskLocalDatasource,
        ),

        ///Remote storage for Task
        RepositoryProvider<TaskRemoteDatasource>.value(
          value: _taskRemoteDatasource,
        ),

        ///Remote storage for Local Revision
        RepositoryProvider<RevisionLocalDatasource>.value(
          value: _revisionLocalDatasource,
        ),

        ///Remote storage for Revision
        RepositoryProvider<RevisionRemoteDatasource>.value(
          value: _revisionRemoteDatasource,
        ),

        ChangeNotifierProvider<TaskRouterDelegate>.value(
          value: _taskRouterDelegate,
        ),

        Provider<RouteObserver>.value(
          value: RouteObserver(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            key: const ValueKey('Material'),
            title: _title,

            ///localizations
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,

            ///theme
            theme: FlutterTheme.light,
            //darkTheme: FlutterTheme.dark,

            ///Navigation
            routerDelegate: context.read<TaskRouterDelegate>(),
            routeInformationParser: TaskRouteInformationParser(),
            routeInformationProvider: DebugRouteInformationProvider(),

            ///Other
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
```

А используется через контекст в экранах:

```dart
class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(
        taskLocalDatasource: context.read<TaskLocalDatasource>(),
        taskRemoteDatasource: context.read<TaskRemoteDatasource>(),
        revisionLocalDatasource: context.read<RevisionLocalDatasource>(),
      )..initial(),
      child: const NotesBody(),
    );
  }
}
```

## Обработка ошибок сервера

В стейт менеджере при нициализации работает try cache, которые ловят все возсожные ошибки:

```dart

Future<void> initial(){

  try {

  ...
  // Any code
  ...

  } on NotInternetException catch (_) {

      logger.i('DO TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );

    } on Exception catch (error, stackTrace) {

      /// Передача стейта с ошибкой

      logger.e('DONE TASK:', error, stackTrace);
      emit(
        NotesFailureState(
          error: error,
          tasks: state.tasks,
          filter: state.filter,
        ),
      );

    } finally {
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    }
}
```

Вывод ошибки происходит в Widget BlocListener, который запускает AlertDialog:

```dart
class NotePage extends StatelessWidget {
  final String? id;
  const NotePage({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(
        taskRemoteDatasource: context.read<TaskRemoteDatasource>(),
        taskLocalDatasource: context.read<TaskLocalDatasource>(),
        revisionLocalDatasource: context.read<RevisionLocalDatasource>(),
      )..initial(id),
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteFailureState) {
            late String message;
            switch (state.error) {
              case BadRequestException():
                message = S.of(context).get(SName.badRequest);
              case UnauthorizedException():
                message = S.of(context).get(SName.unauthorized);
              case NotFoundException():
                message = S.of(context).get(SName.notFound);
              case ServerErrorException():
                message = S.of(context).get(SName.serverError);
              case NotInternetException():
                message = S.of(context).get(SName.notInternet);
              case UnknownException():
                message = S.of(context).get(SName.unknownException);
              default:
                message = S.of(context).get(SName.veryUnknownException);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
        child: const Scaffold(
          appBar: NoteHeader(),
          body: NoteBody(),
        ),
      ),
    );
  }
}
```




