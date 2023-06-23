import 'package:equatable/equatable.dart';
import 'package:note/domain/entity/task.dart';

sealed class NotesState extends Equatable {
  bool get filter => false;

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
  final bool filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NotesProgressState({this.tasks, this.filter = false});
}

final class NotesSuccessState extends NotesState {
  @override
  final bool filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NotesSuccessState({required this.tasks, this.filter = false});
}

final class NotesTemporaryState extends NotesState {
  @override
  final bool filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NotesTemporaryState({required this.tasks, this.filter = false});
}

final class NotesFailureState extends NotesState {
  final String message;

  @override
  final bool filter;

  @override
  final List<Task>? tasks;

  @override
  List<Object?> get props => [tasks, filter];

  const NotesFailureState(
    this.message, {
    this.tasks,
    this.filter = false,
  });
}

enum FilterTask { all, notDone }
