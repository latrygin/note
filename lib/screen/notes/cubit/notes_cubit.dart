import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:note/domain/api/request/task_list_request.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/provider/revision/local_revision_provider_impl.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/domain/service/task/task_service_impl.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/utils/logger/logger.dart';

class NotesCubit extends Cubit<NotesState> {
  final TaskProviderImpl _taskProvider;
  final TaskServiceImpl _taskService;
  final LocalRevisionProviderImpl _localRevisionProvider;

  NotesCubit({
    required TaskProviderImpl taskProvider,
    required TaskServiceImpl taskService,
    required LocalRevisionProviderImpl localRevisionProvider,
  })  : _taskProvider = taskProvider,
        _taskService = taskService,
        _localRevisionProvider = localRevisionProvider,
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
      final localTasks = await _taskProvider.getAll();

      ///Start Temporary State
      emit(
        NotesTemporaryState(
          tasks: localTasks,
          filter: state.filter,
        ),
      );

      if (_localRevisionProvider.get()) {
        logger.i('Новые задачи, о которых не знает сервер');
        final taskListRequest = await _taskService.patch(
          TaskListRequest(list: localTasks),
        );
        emit(
          NotesSuccessState(
            tasks: taskListRequest.list,
            filter: state.filter,
          ),
        );
        await _localRevisionProvider.set(false);
        return;
      } else {
        ///Get all tasks
        final remoteTasks = await _taskService.getAll();

        await _taskProvider.patch(remoteTasks.list);

        ///Start Success State
        emit(
          NotesSuccessState(
            tasks: remoteTasks.list,
            filter: state.filter,
          ),
        );
      }
    } on DioException catch (e, stackTrace) {
      logger.i('Нет интернета');
      log(
        e.toString(),
        error: e,
        stackTrace: stackTrace,
      );
      await _localRevisionProvider.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Object catch (error, stackTrace) {
      log(
        'INITIAL TASK:',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        NotesFailureState(
          error.toString(),
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
      await _taskProvider.updateAt(task);

      ///Start Temporary State
      emit(
        NotesTemporaryState(
          tasks: state.tasks!..[index] = task,
          filter: state.filter,
        ),
      );

      ///Change task
      await _taskService.put(task);

      ///Start Success State
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on DioException catch (_) {
      logger.i('DO TASK: Нет интернета');
      await _localRevisionProvider.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Object catch (e) {
      logger.e('DONE TASK: $e');
      emit(
        NotesFailureState(
          e.toString(),
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
      await _taskProvider.removeAt(id);

      final tasks = await _taskProvider.getAll();

      ///Start Temporary State
      emit(
        NotesTemporaryState(
          tasks: tasks,
          filter: state.filter,
        ),
      );

      ///Delete task
      await _taskService.delete(id);

      ///Start Success State
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on DioException catch (_) {
      logger.i('DELETE TASK: Нет интернета');
      await _localRevisionProvider.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Object catch (e) {
      logger.e('DELETE TASK: $e');
      emit(
        NotesFailureState(
          e.toString(),
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

        await _taskProvider.create(task);

        final tasks = await _taskProvider.getAll();

        emit(
          NotesTemporaryState(
            tasks: tasks,
            filter: state.filter,
          ),
        );

        ///Create task
        await _taskService.post(task);

        ///Start Success State
        emit(
          NotesSuccessState(
            tasks: state.tasks,
            filter: state.filter,
          ),
        );
      }
    } on DioException catch (_) {
      logger.i('ADD TASK: Нет интернета');
      await _localRevisionProvider.set(true);
      emit(
        NotesSuccessState(
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    } on Object catch (e) {
      logger.e('ADD TASK: $e');
      emit(
        NotesFailureState(
          e.toString(),
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
    try {
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
    } on Object catch (e) {
      logger.e('FILTER TASK: $e');
      emit(
        NotesFailureState(
          e.toString(),
          tasks: state.tasks,
          filter: state.filter,
        ),
      );
    }
  }
}
