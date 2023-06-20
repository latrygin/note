import 'package:bloc/bloc.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/utils/logger/logger.dart';

class NotesCubit extends Cubit<NotesState> {
  final TaskProviderImpl _taskFacade;
  NotesCubit({
    required TaskProviderImpl taskFacade,
  })  : _taskFacade = taskFacade,
        super(const NoteInitialState());

  Future<void> initial() async {
    try {
      emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
      final tasks = await _taskFacade.getAll(filter: state.filter);
      emit(NoteSuccessState(tasks: tasks, filter: state.filter));
    } on Object catch (e) {
      logger.e(e);
      emit(NoteFailureState(e.toString()));
    }
  }

  Future<void> filter() async {
    try {
      switch (state.filter) {
        case FilterTask.all:
          emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
          final tasks = await _taskFacade.getAll(filter: FilterTask.notDone);
          emit(NoteSuccessState(tasks: tasks, filter: FilterTask.notDone));
          break;
        case FilterTask.notDone:
          emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
          final tasks = await _taskFacade.getAll();
          emit(NoteSuccessState(tasks: tasks));
          break;
        default:
          return;
      }
    } on Object catch (e) {
      logger.e(e);
      emit(NoteFailureState(e.toString()));
    }
  }

  Future<void> doneTask(int index, bool done) async {
    try {
      emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
      await _taskFacade.updateAt(index: index, done: done);
      final tasks = await _taskFacade.getAll(filter: state.filter);
      emit(NoteSuccessState(tasks: tasks, filter: state.filter));
    } on Object catch (e) {
      logger.e(e);
      emit(NoteFailureState(e.toString()));
    }
  }

  Future<void> deleteTask(int index) async {
    try {
      emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
      await _taskFacade.removeAt(index);
      final tasks = await _taskFacade.getAll(filter: state.filter);
      emit(NoteSuccessState(tasks: tasks, filter: state.filter));
    } on Object catch (e) {
      logger.e(e);
      emit(NoteFailureState(e.toString()));
    }
  }

  Future<void> addTask(String? text) async {
    try {
      if (text != null) {
        emit(NoteProgressState(tasks: state.tasks, filter: state.filter));
        await _taskFacade.add(text: text, important: TaskImportant.basic);
        final tasks = await _taskFacade.getAll(filter: state.filter);
        emit(NoteSuccessState(tasks: tasks, filter: state.filter));
      }
    } on Object catch (e) {
      logger.e(e);
      emit(NoteFailureState(e.toString()));
    }
  }
}
