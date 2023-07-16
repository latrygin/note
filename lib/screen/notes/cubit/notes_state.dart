import 'package:equatable/equatable.dart';
import 'package:note/domain/entity/task.dart';

sealed class NotesState extends Equatable {
  List<Task>? get tasks => null;

  const NotesState();
}

final class NotesInitialState extends NotesState {
  @override
  List<Object?> get props => [];

  const NotesInitialState();
}

final class NotesProgressState extends NotesState {
  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks];

  const NotesProgressState(this.tasks);
}

final class NotesSuccessState extends NotesState {
  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks];

  const NotesSuccessState(this.tasks);
}

final class NotesTemporaryState extends NotesState {
  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks];

  const NotesTemporaryState(this.tasks);
}

final class NotesFailureState extends NotesState {
  final Exception error;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks];

  const NotesFailureState(this.error, this.tasks);
}
