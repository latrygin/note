import 'package:equatable/equatable.dart';
import 'package:note/domain/entity/task.dart';

sealed class NoteState extends Equatable {
  Task get task => Task.create('');
  bool get create => true;

  const NoteState();
}

final class NoteInitialState extends NoteState {
  const NoteInitialState();
  @override
  List<Object?> get props => [];
}

final class NoteProgressState extends NoteState {
  @override
  final bool create;

  @override
  final Task task;

  const NoteProgressState({
    required this.task,
    required this.create,
  });

  @override
  List<Object?> get props => [task, create];
}

final class NoteSuccessState extends NoteState {
  @override
  final bool create;

  @override
  final Task task;

  const NoteSuccessState({
    required this.task,
    required this.create,
  });

  @override
  List<Object?> get props => [task, create];
}

final class NoteFailureState extends NoteState {
  final String message;

  @override
  final Task task;

  @override
  final bool create;

  const NoteFailureState({
    required this.message,
    required this.task,
    required this.create,
  });

  @override
  List<Object?> get props => [message, task, create];
}
