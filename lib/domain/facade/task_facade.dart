import 'package:note/domain/entity/task.dart';

abstract class TaskFacade {
  Future<List<Task>> getAll();
  Future<Task> getAt(int index);
  Future<Task> updateAt(int index, Task task);
  Future<void> changeStatus(int index, bool isDone);
  Future<void> removeAt(int index);
  Future<void> add(Task task);
}
