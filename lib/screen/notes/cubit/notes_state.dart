part of 'notes_cubit.dart';

final class NotesState extends Equatable {
  final StatusPage status;
  final List<Task>? task;
  const NotesState({
    this.status = StatusPage.loading,
    this.task,
  });

  NotesState copyWith({
    StatusPage? status,
    List<Task>? task,
  }) {
    return NotesState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }

  @override
  List<Object?> get props => [
    status,
        task,
      ];
}

enum StatusPage {
  loading,
  done,
}
