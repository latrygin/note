import 'package:equatable/equatable.dart';
import 'package:note/domain/entity/task.dart';

class NoteState extends Equatable {
  final int? id;
  final String? text;
  final TaskImportant important;
  final DateTime? deadline;

  const NoteState(
    this.id, {
    this.text,
    this.important = TaskImportant.basic,
    this.deadline,
  });

  NoteState copyWith({
    String? text,
    TaskImportant? important,
    DateTime? deadline,
  }) {
    return NoteState(
      id,
      text: text ?? this.text,
      important: important ?? this.important,
      deadline: deadline ?? this.deadline,
    );
  }

  NoteState setDate({
    DateTime? day,
  }) {
    return NoteState(
      id,
      text: text,
      important: important,
      deadline: day,
    );
  }

  @override
  List<Object?> get props => [id, text, important, deadline];
}
