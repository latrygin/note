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
      emit(
        NotesProgressState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );

      ///Get all tasks from local storage
      final localTasks = await _taskLocalDatasource.getAll();

      ///Start Temporary State
      emit(
        NotesTemporaryState(
          tasks: localTasks,
          filter: state.filter,
        ),
      );

      if (_revisionLocalDatasource.get()) {
        logger.i('Новые задачи, о которых не знает сервер');
        final taskListRequest = await _taskRemoteDatasource.patch(
          TaskListRequest(list: localTasks),
        );
        emit(
          NotesSuccessState(
            tasks: taskListRequest.list,
            filter: state.filter,
          ),
        );
        await _revisionLocalDatasource.set(false);
        return;
      } else {
        ///Get all tasks
        final remoteTasks = await _taskRemoteDatasource.getAll();

        await _taskLocalDatasource.patch(remoteTasks.list);

        ///Start Success State
        emit(
          NotesSuccessState(
            tasks: remoteTasks.list,
            filter: state.filter,
          ),
        );
        return;
      }
    } on NotInternetException catch (_) {
      logger.i('Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Exception catch (error, stackTrace) {
      logger.e('INITIAL TASK:', error, stackTrace);
      emit(
        NotesFailureState(
          error: error,
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } finally {
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    }
  }

  Future<void> doneTask(int index, bool done) async {
    try {
      ///Start Loading State
      emit(
        NotesProgressState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );

      final task = state.tasks![index].copyWith(
        done: done,
        changedAt: DateTime.now(),
      );

      ///Update local task
      await _taskLocalDatasource.updateAt(task);

      final tasks = await _taskLocalDatasource.getAll();

      ///Start Temporary State
      emit(
        NotesTemporaryState(
          tasks: tasks,
          filter: state.filter,
        ),
      );

      ///Change task
      await _taskRemoteDatasource.put(task);

      ///Start Success State
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on NotInternetException catch (_) {
      logger.i('DO TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Exception catch (error, stackTrace) {
      logger.e('DONE TASK:', error, stackTrace);
      emit(
        NotesFailureState(
          error: error,
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } finally {
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    }
  }

  Future<void> deleteTask(int index) async {
    try {
      ///Start Loading State
      emit(
        NotesProgressState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );

      final id = state.tasks![index].id;

      ///Update local task
      await _taskLocalDatasource.removeAt(id);

      final tasks = await _taskLocalDatasource.getAll();

      ///Start Temporary State
      emit(
        NotesTemporaryState(
          tasks: tasks,
          filter: state.filter,
        ),
      );

      ///Delete task
      await _taskRemoteDatasource.delete(id);

      ///Start Success State
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on NotInternetException catch (_) {
      logger.i('DELETE TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Exception catch (error, stackTrace) {
      logger.e('DELETE TASK:', error, stackTrace);
      emit(
        NotesFailureState(
          error: error,
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } finally {
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    }
  }

  Future<void> addTask(String text) async {
    try {
      if (text.trim().isNotEmpty) {
        ///Start Loading State
        emit(
          NotesProgressState(
            tasks: state.tasks,
            filter: state.filter,
          ),
        );

        final task = Task.create(text);

        await _taskLocalDatasource.create(task);

        final tasks = await _taskLocalDatasource.getAll();

        emit(
          NotesTemporaryState(
            tasks: tasks,
            filter: state.filter,
          ),
        );

        ///Create task
        await _taskRemoteDatasource.post(task);

        ///Start Success State
        emit(
          NotesSuccessState(
            tasks: state.tasks,
            filter: state.filter,
          ),
        );
      }
    } on NotInternetException catch (_) {
      logger.i('ADD TASK: Нет интернета');
      await _revisionLocalDatasource.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Exception catch (error, stackTrace) {
      logger.e('ADD TASK:', error, stackTrace);
      emit(
        NotesFailureState(
          error: error,
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } finally {
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    }
  }

  void filter() {
    ///Start Loading State
    emit(
      NotesProgressState(
        tasks: state.tasks,
        filter: state.filter,
      ),
    );

    ///Start Success State
    emit(
      NotesSuccessState(
        tasks: state.tasks,
        filter: !state.filter,
      ),
    );
  }
}
