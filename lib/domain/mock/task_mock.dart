import 'package:note/domain/entity/task.dart';
import 'package:note/domain/facade/task_facade.dart';

class TaskMock implements TaskFacade {
  List<Task> tasks = [
    Task(
      title: 'Купить что-то',
    ),
    Task(
      title: 'Купить что-то, где-то, зачем-то, но зачем не очень понятно',
    ),
    Task(
      title:
          'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезается описание задачи',
    ),
    Task(
      title: 'Купить что-то',
      priority: TaskPriority.low,
    ),
    Task(
      title: 'Купить что-то',
      priority: TaskPriority.high,
    ),
    Task(
      title: 'Купить что-то',
      isDone: true,
    ),
    Task(
      title: 'Купить что-то',
      date: DateTime.now(),
    ),
    Task(
      title: 'Купить что-то',
      priority: TaskPriority.low,
    ),
    Task(
      title: 'Купить что-то',
      priority: TaskPriority.high,
    ),
    Task(
      title: 'Купить что-то',
      isDone: true,
    ),
    Task(
      title: 'Купить что-то',
      date: DateTime.now(),
    ),
  ];

  @override
  Future<List<Task>> getAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return tasks;
  }

  @override
  Future<Task> getAt(int index) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return tasks[index];
  }

  @override
  Future<void> removeAt(int index) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    tasks.removeAt(index);
    return;
  }

  @override
  Future<Task> updateAt(int index, Task task) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    tasks[index] = task;
    return tasks[index];
  }

  @override
  Future<void> add(Task task) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    tasks.add(task);
  }

  @override
  Future<void> changeStatus(int index, bool isDone) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    tasks[index] = tasks[index].copyWith(isDone: isDone);
  }
}
