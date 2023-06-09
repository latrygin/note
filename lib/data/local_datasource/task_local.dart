import 'package:device_info_plus/device_info_plus.dart';
import 'package:isar/isar.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:path_provider/path_provider.dart';

class TaskLocal implements TaskLocalDatasource {
  final DeviceInfoPlugin _device;
  TaskLocal({required DeviceInfoPlugin device}) : _device = device;

  Isar? _isar;

  Future<Isar> get _box async {
    final dir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open(
      [TaskSchema],
      directory: dir.path,
    );
    return _isar!;
  }

  @override
  Future<Task> create(Task task) async {
    final deviceInfo = await _device.androidInfo;
    final newTask = task.copyWith(lastUpdatedBy: deviceInfo.id);
    final isar = await _box;
    await isar.writeTxn(() async {
      await isar.tasks.put(newTask);
    });
    return newTask;
  }

  @override
  Future<List<Task>> getAll() async {
    final isar = await _box;
    final tasks = await isar.tasks.where().sortByCreatedAt().findAll();
    return tasks;
  }

  @override
  Future<Task> getAt(String id) async {
    final isar = await _box;
    final task = await isar.tasks.filter().idEqualTo(id).findFirst() as Task;
    return task;
  }

  @override
  Future<List<Task>> patch(List<Task> tasks) async {
    final isar = await _box;
    await isar.writeTxn(() async {
      await isar.tasks.clear();
      await isar.tasks.putAll(tasks);
    });
    return tasks;
  }

  @override
  Future<void> removeAt(String id) async {
    final isar = await _box;
    await isar.writeTxn(() async {
      await isar.tasks.filter().idEqualTo(id).deleteFirst();
    });
  }

  @override
  Future<Task> updateAt(Task task) async {
    final isar = await _box;
    await isar.writeTxn(() async {
      await isar.tasks.put(task.copyWith(changedAt: DateTime.now()));
    });
    return task;
  }
}
