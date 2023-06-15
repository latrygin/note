import 'package:bloc/bloc.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/facade/task_facade.dart';
import 'package:note/utils/logger/logger.dart';
import 'package:note/utils/navigation/navigation.dart';

import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final TaskFacade _taskFacade;

  NoteCubit({
    required int? id,
    required TaskFacade taskFacade,
  })  : _taskFacade = taskFacade,
        super(NoteState(id));

  Future<void> initial() async {
    try {
      if (state.id == null) {
        return;
      } else {
        final task = await _taskFacade.getAt(state.id!);
        emit(
          state.copyWith(
            text: task.text,
            important: task.important,
            deadline: task.deadline,
          ),
        );
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  void setTitle(String text) => emit(state.copyWith(text: text));

  void setPriority(TaskImportant important) =>
      emit(state.copyWith(important: important));

  void setDate(DateTime? deadline) => emit(state.setDate(day: deadline));

  Future<void> saveTask() async {
    try {
      if (state.text != null && state.id == null) {
        await _taskFacade.add(
          text: state.text!,
          important: state.important,
          deadline: state.deadline,
        );
      } else if (state.text != null && state.id != null) {
        await _taskFacade.updateAt(
          index: state.id!,
          text: state.text,
          important: state.important,
          deadline: state.deadline,
        );
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<void> delete() async {
    try {
      await _taskFacade.removeAt(state.id!);
    } on Exception catch (e) {
      logger.e(e);
    } finally {
      NavigationManager.instance.popToHome();
    }
  }
}
