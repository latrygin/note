import 'package:equatable/equatable.dart';
import 'package:note/domain/entity/task.dart';

sealed class NotesState extends Equatable {
  FilterTask get filter => FilterTask.all;

  List<Task>? get tasks => null;

  const NotesState();
}

final class NoteInitialState extends NotesState {
  @override
  List<Object?> get props => [];

  const NoteInitialState();
}

final class NoteProgressState extends NotesState {
  @override
  final FilterTask filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NoteProgressState({this.tasks, this.filter = FilterTask.all});
}

final class NoteSuccessState extends NotesState {
  @override
  final FilterTask filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NoteSuccessState({required this.tasks, this.filter = FilterTask.all});
}

final class NoteFailureState extends NotesState {
  final String message;

  @override
  final FilterTask filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NoteFailureState(
    this.message, {
    this.tasks,
    this.filter = FilterTask.all,
  });
}

enum FilterTask { all, notDone }
