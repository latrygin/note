import 'package:bloc/bloc.dart';
import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/core/exception/exception.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/utils/logger/logger.dart';

class NotesCubit extends Cubit<NotesState> {
  final TaskLocalDatasource _taskLocalDatasource;
  final TaskRemoteDatasource _taskRemoteDatasource;
  final RevisionLocalDatasource _revisionLocalDatasource;

  NotesCubit({
    required TaskLocalDatasource taskLocalDatasource,
    required TaskRemoteDatasource taskRemoteDatasource,
    required RevisionLocalDatasource revisionLocalDatasource,
  })  : _taskLocalDatasource = taskLocalDatasource,
        _taskRemoteDatasource = taskRemoteDatasource,
        _revisionLocalDatasource = revisionLocalDatasource,
        super(const NotesInitialState());

  Future<void> initial() async {
    try {
      ///Start Progress State
      emit(NotesProgressState(state.tasks));

      ///Get all tasks from local storage
      final localTasks = await _taskLocalDatasource.getAll();

      ///Start Temporary State
      emit(
        NotesTemporaryState(localTasks),
      );

      if (_revisionLocalDatasource.get()) {
        logger.i('Новые задачи, о которых не знает сервер');
        final taskListRequest = await _taskRemoteDatasource.patch(
          TaskListRequest(list: localTasks),
        );
        emit(
          NotesSuccessState(taskListRequest.list),
        );
        await _revisionLocalDatasource.set(false);
        return;
      } else {
        ///Get all tasks
        final remoteTasks = await _taskRemoteDatasource.getAll();

        await _taskLocalDatasource.patch(remoteTasks.list);

        ///Start Success State
        emit(NotesSuccessState(remoteTasks.list));
        return;
      }
    } on NotInternetException catch (_) {
      logger.i('Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(NotesSuccessState(state.tasks));
    } on Exception catch (error, stackTrace) {
      logger.e('INITIAL TASK:', error, stackTrace);
      emit(NotesFailureState(error, state.tasks));
    } finally {
      emit(NotesSuccessState(state.tasks));
    }
  }

  Future<void> doneTask(int index, bool done) async {
    try {
      ///Start Loading State
      emit(NotesProgressState(state.tasks));

      final task = state.tasks![index].copyWith(
        done: done,
        changedAt: DateTime.now(),
      );

      ///Update local task
      await _taskLocalDatasource.updateAt(task);

      final tasks = await _taskLocalDatasource.getAll();

      ///Start Temporary State
      emit(NotesTemporaryState(tasks));

      ///Change task
      await _taskRemoteDatasource.put(task);

      ///Start Success State
      emit(NotesSuccessState(state.tasks));
    } on NotInternetException catch (_) {
      logger.i('DO TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(NotesSuccessState(state.tasks));
    } on Exception catch (error, stackTrace) {
      logger.e('DONE TASK:', error, stackTrace);
      emit(NotesFailureState(error, state.tasks));
    } finally {
      emit(NotesSuccessState(state.tasks));
    }
  }

  Future<void> deleteTask(int index) async {
    try {
      ///Start Loading State
      emit(NotesProgressState(state.tasks));

      final id = state.tasks![index].id;

      ///Update local task
      await _taskLocalDatasource.removeAt(id);

      final tasks = await _taskLocalDatasource.getAll();

      ///Start Temporary State
      emit(NotesTemporaryState(tasks));

      ///Delete task
      await _taskRemoteDatasource.delete(id);

      ///Start Success State
      emit(NotesSuccessState(state.tasks));
    } on NotInternetException catch (_) {
      logger.i('DELETE TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(NotesSuccessState(state.tasks));
    } on Exception catch (error, stackTrace) {
      logger.e('DELETE TASK:', error, stackTrace);
      emit(NotesFailureState(error, state.tasks));
    } finally {
      emit(
        NotesSuccessState(state.tasks),
      );
    }
  }

  Future<void> addTask(String text) async {
    try {
      if (text.trim().isNotEmpty) {
        ///Start Loading State
        emit(NotesProgressState(state.tasks));

        final task = Task.create(text);

        await _taskLocalDatasource.create(task);

        final tasks = await _taskLocalDatasource.getAll();

        emit(NotesTemporaryState(tasks));

        ///Create task
        await _taskRemoteDatasource.post(task);

        ///Start Success State
        emit(NotesSuccessState(state.tasks));
      }
    } on NotInternetException catch (_) {
      logger.i('ADD TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(NotesSuccessState(state.tasks));
    } on Exception catch (error, stackTrace) {
      logger.e('ADD TASK:', error, stackTrace);
      emit(NotesFailureState(error, state.tasks));
    } finally {
      emit(NotesSuccessState(state.tasks));
    }
  }

  void filter() {
    ///Start Loading State
    emit(NotesProgressState(state.tasks));

    ///Start Success State
    emit(NotesSuccessState(state.tasks));
  }
}
