import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/facade/task_facade.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final TaskFacade _taskFacade;
  NotesCubit({
    required TaskFacade taskFacade,
  })  : _taskFacade = taskFacade,
        super(const NotesState());

  Future<void> initial() async {
    final tasks = await _taskFacade.getAll();
    emit(state.copyWith(task: tasks, status: StatusPage.done));
    developer.log('Initial: ${tasks.length}');
  }

  Future<void> doneTask(int index, bool isDone) async {
    emit(state.copyWith(status: StatusPage.loading));
    developer.log('Done: $index');
    await _taskFacade.changeStatus(index, isDone);
    await initial();
  }

  Future<void> deleteTask(int index) async {
    emit(state.copyWith(status: StatusPage.loading));
    developer.log('Deleted: $index');
    await _taskFacade.removeAt(index);
    await initial();
  }

  Future<void> addTask() async {
    emit(state.copyWith(status: StatusPage.loading));
    developer.log('Add: ');
    await _taskFacade.add(Task(title: '123123'));
    await initial();
  }
}
