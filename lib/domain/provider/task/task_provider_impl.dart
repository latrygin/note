import 'package:note/domain/entity/task.dart';

abstract class TaskProviderImpl {
  Future<List<Task>> getAll();
  Future<Task> getAt(String id);
  Future<Task> updateAt(Task task);
  Future<void> removeAt(String id);
  Future<Task> create(Task task);
  Future<List<Task>> patch(List<Task> tasks);
}
