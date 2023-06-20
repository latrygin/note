import 'package:note/domain/entity/task.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';

import 'task_provider_impl.dart';

class TaskProvider implements TaskProviderImpl {
  @override
  Future<void> add({
    required String text,
    required TaskImportant important,
    DateTime? deadline,
  }) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAll({
    FilterTask filter = FilterTask.all,
  }) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Task> getAt(int index) {
    // TODO: implement getAt
    throw UnimplementedError();
  }

  @override
  Future<void> removeAt(int index) {
    // TODO: implement removeAt
    throw UnimplementedError();
  }

  @override
  Future<void> updateAt({
    required int index,
    String? text,
    TaskImportant? important,
    DateTime? deadline,
    bool? done,
  }) {
    // TODO: implement updateAt
    throw UnimplementedError();
  }
}
