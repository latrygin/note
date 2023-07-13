import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/entity/task_importance.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';
import 'package:note/screen/note/cubit/note_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('EDIT: NoteCubit', () {
    late NoteCubit noteCubit;
    late TaskLocalDatasource taskLocalMock;
    late TaskRemoteDatasource taskRemoteMock;
    late RevisionLocalDatasource revisionLocalMock;
    late Task editTask;

    setUpAll(() async {
      taskLocalMock = TaskLocalMock();
      taskRemoteMock = TaskRemoteMock();
      revisionLocalMock = RevisionLocalMock();
      final tasks = await taskLocalMock.getAll();
      await taskRemoteMock.patch(TaskListRequest(list: tasks));
      editTask = tasks[0];
    });

    setUp(() async {
      noteCubit = NoteCubit(
        taskLocalDatasource: taskLocalMock,
        taskRemoteDatasource: taskRemoteMock,
        revisionLocalDatasource: revisionLocalMock,
      );
      await noteCubit.initial(editTask.id);
    });

    test('Check create state', () {
      expect(noteCubit.state.create, false);
    });

    test('Check set Title', () {
      const title = 'Edit task';
      noteCubit.setTitle(title);
      expect(noteCubit.state.task.text, title);
    });

    test('Check set priority', () {
      const important = TaskImportant.important;
      noteCubit.setPriority(important);
      expect(noteCubit.state.task.importance, important);
    });

    test('Check set deadline', () {
      final deadline = DateTime.now();
      noteCubit.setDate(deadline);
      expect(noteCubit.state.task.deadline, deadline);
    });

    test('Check set null deadline', () {
      noteCubit.setDate(null);
      expect(noteCubit.state.task.deadline, null);
    });

    test('Check save task', () async {
      await noteCubit.saveTask();
      expect(noteCubit.state.create, false);
    });
  });
}
