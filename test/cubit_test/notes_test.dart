import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/data/mock_datasource/task_local_mock.dart';
import 'package:note/data/mock_datasource/task_remote_mock.dart';
import 'package:note/screen/notes/cubit/notes_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('NotesCubit', () {
    late NotesCubit notesCubit;
    late TaskLocalMock taskLocalMock;
    late TaskRemoteMock taskRemoteMock;
    late RevisionLocalMock revisionLocalMock;

    setUpAll(() async {
      taskLocalMock = TaskLocalMock();
      taskRemoteMock = TaskRemoteMock();
      revisionLocalMock = RevisionLocalMock();
      final tasks = await taskLocalMock.getAll();
      await taskRemoteMock.patch(TaskListRequest(list: tasks));
    });

    setUp(() async {
      notesCubit = NotesCubit(
        taskLocalDatasource: taskLocalMock,
        taskRemoteDatasource: taskRemoteMock,
        revisionLocalDatasource: revisionLocalMock,
      );
    });

    test('Check filter', () {
      expect(notesCubit.state.filter, false);
    });

    test('Check change filter', () {
      notesCubit.filter();
      expect(notesCubit.state.filter, true);
    });
  });
}
