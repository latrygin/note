import 'package:note/domain/entity/task.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';

abstract class TaskProviderImpl {
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
