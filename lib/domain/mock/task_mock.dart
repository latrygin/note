import 'package:note/domain/entity/task.dart';
import 'package:note/domain/facade/task_facade.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/utils/exception/not_found_exception.dart';
import 'package:note/utils/logger/logger.dart';

class TaskMock implements TaskFacade {
  int autoId = 11;
  @override
  Future<List<Task>> getAll({FilterTask filter = FilterTask.all}) async {
    await Future<void>.delayed(Duration.zero);
    logger.i('Get all tasks');
    if (filter == FilterTask.all) {
      return tasks;
    } else {
      final filterTask = <Task>[];
      for (final element in tasks) {
        if (!element.done) filterTask.add(element);
      }
      return filterTask;
    }
  }

  @override
  Future<Task> getAt(int index) async {
    await Future<void>.delayed(Duration.zero);
    for (final element in tasks) {
      if (element.id == index) {
        logger.i('Get $index task');
        return element;
      }
    }
    throw NotFoundException();
  }

  @override
  Future<void> removeAt(int index) async {
    await Future<void>.delayed(Duration.zero);
    for (final element in tasks) {
      if (element.id == index) {
        tasks.remove(element);
        logger.i('Delete $index task');
        return;
      }
    }
    logger.e('NOT delete $index task');
    return;
  }

  @override
  Future<void> updateAt({
    required int index,
    String? text,
    TaskImportant? important,
    DateTime? deadline,
    bool? done,
  }) async {
    await Future<void>.delayed(Duration.zero);
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].id == index) {
        tasks[i].text = text ?? tasks[i].text;
        tasks[i].important = important ?? tasks[i].important;
        tasks[i].deadline = deadline;
        tasks[i].done = done ?? tasks[i].done;
        tasks[i].changedAt = DateTime.now();
        logger.i('Update $index task');
        return;
      }
    }
    logger.e('NOT update $index task');
    return;
  }

  @override
  Future<void> add({
    required String text,
    required TaskImportant important,
    DateTime? deadline,
  }) async {
    await Future<void>.delayed(Duration.zero);
    final newTask = Task(
      id: ++autoId,
      text: text,
      important: important,
      deadline: deadline,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    );
    tasks.add(newTask);
    logger.i('Add task');
  }

  List<Task> tasks = [
    Task(
      id: 1,
      text: 'Купить что-то',
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 2,
      text: 'Купить что-то, где-то, зачем-то, но зачем не очень понятно',
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 3,
      text:
          'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезается описание задачи',
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 4,
      text: 'Купить что-то',
      important: TaskImportant.low,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 5,
      text: 'Купить что-то',
      important: TaskImportant.important,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 6,
      text: 'Купить что-то',
      done: true,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 7,
      text: 'Купить что-то',
      deadline: DateTime.now(),
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 8,
      text: 'Купить что-то',
      important: TaskImportant.low,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 9,
      text: 'Купить что-то',
      important: TaskImportant.important,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 10,
      text: 'Купить что-то',
      done: true,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      id: 11,
      text: 'Купить что-то',
      deadline: DateTime.now(),
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
  ];
}
