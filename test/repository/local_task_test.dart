import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:test/test.dart';

void main() {
  group('LOCAL TASK', () {
    late TaskLocalDatasource taskLocalDatasource;
    var tasks = <Task>[
      Task.create('test1'),
      Task.create('test2'),
      Task.create('test3'),
    ];

    setUpAll(() async {
      taskLocalDatasource = TaskLocalMock();
      tasks = await taskLocalDatasource.patch(tasks);
    });

    test('get all', () async {
      final task = await taskLocalDatasource.getAll();
      expect(task, tasks);
    });

    test('patch', () async {
      final task = await taskLocalDatasource.patch(tasks);
      expect(task, tasks);
    });

    test('get at', () async {
      final task = await taskLocalDatasource.getAt(tasks[0].id);
      expect(task, tasks[0]);
    });

    test('remove at', () async {
      final len = tasks.length;
      await taskLocalDatasource.removeAt(tasks[0].id);
      final task = await taskLocalDatasource.getAll();
      expect(len - 1, task.length);
    });

    test('create', () async {
      final len = tasks.length;
      await taskLocalDatasource.create(Task.create('new task'));
      final task = await taskLocalDatasource.getAll();
      expect(len + 1, task.length);
    });

    test('update At', () async {
      await taskLocalDatasource
          .updateAt(tasks[0].copyWith(text: 'change task'));
      final task = await taskLocalDatasource.getAll();
      expect(tasks[0].copyWith(text: 'change task').text, task[0].text);
    });
  });
}
