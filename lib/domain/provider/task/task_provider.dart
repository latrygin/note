// ignore_for_file: strict_raw_type

//
// class TaskProvider implements TaskProviderImpl {
//   Box<List>? _box;
//   final _device = DeviceInfoPlugin();
//   static const String _key = 'task';
//
//   Future<Box<List>> get _getBox async {
//     if (!Hive.isAdapterRegistered(1)) {
//       Hive.registerAdapter(TaskAdapter());
//     }
//     if (!Hive.isAdapterRegistered(2)) {
//       Hive.registerAdapter(TaskImportantAdapter());
//     }
//     _box ??= await Hive.openBox<List>(_key);
//     return _box!;
//   }
//
//   @override
//   Future<Task> create(Task task) async {
//     final deviceInfo = await _device.androidInfo;
//     final newTask = task.copyWith(lastUpdatedBy: deviceInfo.id);
//     final box = await _getBox;
//     final tasks = box.get(_key)!.cast<Task>();
//     await box.put(
//       _key,
//       tasks..add(newTask),
//     );
//     return newTask;
//   }
//
//   @override
//   Future<List<Task>> getAll() async {
//     final box = await _getBox;
//     final tasks = box.get(_key, defaultValue: [])!.cast<Task>();
//     return tasks;
//   }
//
//   @override
//   Future<Task> getAt(String id) async {
//     final box = await _getBox;
//     final tasks = box.get(_key)!.cast<Task>();
//     for (var i = 0; i < (tasks.length ?? 0); i++) {
//       if (tasks[i].id == id) {
//         return tasks[i];
//       }
//     }
//     throw NotFoundException();
//   }
//
//   @override
//   Future<void> removeAt(String id) async {
//     final box = await _getBox;
//     final tasks = box.get(_key)!.cast<Task>();
//     for (var i = 0; i < (tasks.length ?? 0); i++) {
//       if (tasks[i].id == id) {
//         await box.put(_key, tasks..removeAt(i));
//       }
//     }
//   }
//
//   @override
//   Future<Task> updateAt(Task task) async {
//     final box = await _getBox;
//     final tasks = box.get(_key)!.cast<Task>();
//     for (var i = 0; i < (tasks.length ?? 0); i++) {
//       if (tasks[i].id == task.id) {
//         tasks[i] = task;
//         await box.put(_key, tasks);
//         return tasks[i];
//       }
//     }
//     throw NotFoundException();
//   }
//
//   @override
//   Future<List<Task>> patch(List<Task> tasks) async {
//     final box = await _getBox;
//     await box.delete(_key);
//     await box.put(_key, tasks);
//     return tasks;
//   }
// }
