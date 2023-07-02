import 'package:note/core/exception/not_found_exception.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/task_local_impl.dart';

class TaskLocalMock implements TaskLocalDatasourceImpl {
  List<Task> _tasks = <Task>[
    Task.create('text1'),
    Task.create('text2'),
    Task.create('text3'),
    Task.create('text4'),
  ];

  @override
  Future<Task> create(Task task) {
    _tasks.add(task);
    return Future.value(task);
  }

  @override
  Future<List<Task>> getAll() {
    return Future.value(_tasks);
  }

  @override
  Future<Task> getAt(String id) {
    for (final element in _tasks) {
      if (element.id == id) {
        return Future.value(element);
      }
    }
    throw NotFoundException();
  }

  @override
  Future<List<Task>> patch(List<Task> tasks) {
    _tasks = tasks;
    return Future.value(tasks);
  }

  @override
  Future<void> removeAt(String id) {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == id) {
        _tasks.removeAt(i);
        return Future.value();
      }
    }
    throw NotFoundException();
  }

  @override
  Future<Task> updateAt(Task task) {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == task.id) {
        _tasks[i] = task;
        return Future.value(task);
      }
    }
    throw NotFoundException();
  }
}
