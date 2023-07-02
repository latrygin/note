import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/task_remote_impl.dart';
import 'package:test/test.dart';

void main() {
  group('REMOTE TASK', () {
    late TaskRemoteDatasourceImpl taskRemoteDatasource;
    var tasks = <Task>[
      Task.create('test1'),
      Task.create('test2'),
      Task.create('test3'),
    ];

    setUpAll(() async {
      taskRemoteDatasource = TaskRemoteMock();
      final response =
          await taskRemoteDatasource.patch(TaskListRequest(list: tasks));
      tasks = response.list;
    });

    test('get all', () async {
      final task = await taskRemoteDatasource.getAll();
      expect(task.list, tasks);
    });

    test('patch', () async {
      final task =
          await taskRemoteDatasource.patch(TaskListRequest(list: tasks));
      expect(task.list, tasks);
    });

    test('get', () async {
      final task = await taskRemoteDatasource.get(tasks[0].id);
      expect(task.element, tasks[0]);
    });

    test('delete', () async {
      final len = tasks.length;
      await taskRemoteDatasource.delete(tasks[0].id);
      final task = await taskRemoteDatasource.getAll();
      expect(len - 1, task.list.length);
    });

    test('post', () async {
      final len = tasks.length;
      await taskRemoteDatasource.post(Task.create('new task'));
      final task = await taskRemoteDatasource.getAll();
      expect(len, task.list.length);
    });

    test('put', () async {
      final newTask = tasks[1].copyWith(text: 'change task');
      await taskRemoteDatasource.put(newTask);
      final task = await taskRemoteDatasource.getAll();
      tasks = task.list;
      expect(task.list[0].text, tasks[0].text);
    });
  });
}
