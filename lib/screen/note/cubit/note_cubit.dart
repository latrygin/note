import 'package:bloc/bloc.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/entity/task_importance.dart';
import 'package:note/domain/provider/revision/local_revision_provider_impl.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/domain/service/task/task_service_impl.dart';
import 'package:note/utils/exception/exception.dart';
import 'package:note/utils/logger/logger.dart';
import 'package:note/utils/navigation/navigation.dart';

import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final TaskProviderImpl _taskProvider;
  final TaskServiceImpl _taskService;
  final LocalRevisionProviderImpl _localRevisionProvider;

  NoteCubit({
    required TaskProviderImpl taskProvider,
    required TaskServiceImpl taskService,
    required LocalRevisionProviderImpl localRevisionProvider,
  })  : _taskProvider = taskProvider,
        _taskService = taskService,
        _localRevisionProvider = localRevisionProvider,
        super(const NoteInitialState());

  Future<void> initial(String? id) async {
    try {
      if (id == null) {
        ///Set "Create" state
        emit(
          NoteSuccessState(
            task: Task.create(''),
            create: true,
          ),
        );
      } else {
        final localTask = await _taskProvider.getAt(id);

        emit(
          NoteSuccessState(
            task: localTask,
            create: false,
          ),
        );

        ///GET task
        final task = await _taskService.get(id);

        ///Set "Edit" state
        emit(
          NoteSuccessState(
            task: task.element,
            create: false,
          ),
        );
      }
    } on NotInternetException catch (_) {
      logger.i('Нет интернета');
      await _localRevisionProvider.set(true);
      emit(
        NoteSuccessState(
          task: state.task,
          create: state.create,
        ),
      );
    } on Exception catch (error, stackTrace) {
      logger.e('INITIAL TASK:', error, stackTrace);
      emit(
        NoteFailureState(
          error: error,
          task: state.task,
          create: id == null,
        ),
      );
    } finally {
      /// Remove Failure State
      emit(
        NoteSuccessState(
          task: state.task,
          create: state.create,
        ),
      );
    }
  }

  Future<void> saveTask() async {
    try {
      if (state.create) {
        ///Set Progress State
        emit(
          NoteProgressState(
            task: state.task,
            create: state.create,
          ),
        );

        final localTask = await _taskProvider.create(state.task);

        emit(
          NoteProgressState(
            task: localTask,
            create: false,
          ),
        );

        ///Create task
        final task = await _taskService.post(state.task);

        ///Set Success State
        emit(
          NoteSuccessState(
            task: task.element,
            create: false,
          ),
        );
      } else {
        ///Set Progress State
        emit(
          NoteProgressState(
            task: state.task,
            create: state.create,
          ),
        );

        await _taskProvider.updateAt(state.task);

        ///Create task
        final task = await _taskService.put(state.task);

        ///Set Success State
        emit(
          NoteSuccessState(
            task: task.element,
            create: state.create,
          ),
        );
      }
    } on NotInternetException catch (_) {
      logger.i('SAVE TASK: Нет интернета');
      await _localRevisionProvider.set(true);
      emit(
        NoteSuccessState(
          task: state.task,
          create: state.create,
        ),
      );
    } on Exception catch (error, stackTrace) {
      logger.e('SAVE TASK:', error, stackTrace);
      emit(
        NoteFailureState(
          error: error,
          task: state.task,
          create: state.create,
        ),
      );
    } finally {
      /// Remove Failure State
      emit(
        NoteSuccessState(
          task: state.task,
          create: state.create,
        ),
      );
    }
  }

  Future<void> delete() async {
    try {
      ///Set Progress State
      emit(
        NoteProgressState(
          task: state.task,
          create: state.create,
        ),
      );
      await _taskProvider.removeAt(state.task.id);

      /// Delete task
      await _taskService.delete(state.task.id);
    } on NotInternetException catch (_) {
      logger.i('DELETE TASK: Нет интернета');
      await _localRevisionProvider.set(true);
      emit(
        NoteSuccessState(
          task: state.task,
          create: state.create,
        ),
      );
    } on Exception catch (error, stackTrace) {
      ///On Exception method

      logger.e('DELETE TASK:', error, stackTrace);

      emit(
        NoteFailureState(
          error: error,
          task: state.task,
          create: state.create,
        ),
      );
    } finally {
      NavigationManager.instance.popToHome();
    }
  }

  void setTitle(String text) {
    emit(
      NoteProgressState(
        task: state.task,
        create: state.create,
      ),
    );
    emit(
      NoteSuccessState(
        task: state.task.copyWith(text: text),
        create: state.create,
      ),
    );
  }

  void setPriority(TaskImportant important) {
    emit(
      NoteProgressState(
        task: state.task,
        create: state.create,
      ),
    );
    emit(
      NoteSuccessState(
        task: state.task.copyWith(importance: important),
        create: state.create,
      ),
    );
  }

  void setDate(DateTime? deadline) {
    emit(
      NoteProgressState(
        task: state.task,
        create: state.create,
      ),
    );
    emit(
      NoteSuccessState(
        task: state.task.setDate(deadline),
        create: state.create,
      ),
    );
  }
}
