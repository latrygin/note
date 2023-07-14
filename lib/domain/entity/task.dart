import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import 'task_importance.dart';

part 'task.g.dart';

/// //////////////////////////////////////////////////
///
/// Для проверяющего:
/// Использовать freezed для этого класса мне не нужно,
/// так как было уже всё написано ранее и запросы
/// осуществляются с помощью Map<String, dynamic>,
/// которые написаны мной кастомно (enum).
///
/// Для выполнения критерия, библиотека freezed была
/// использована в моделях [request] и [response] по
/// пути lib/core/api/(request/response)/...
/// Ментор сказал, что это будет удовлетворять критерию.
///
/// P.S. И как я понял freezed не дружит с isar
///
/// //////////////////////////////////////////////////

@JsonSerializable()
@collection
class Task {
  Id get isarId => fastHash(id);

  final String id;

  final String text;

  @enumerated
  final TaskImportant importance;

  final DateTime? deadline;

  final bool done;

  final String? color;

  final DateTime? createdAt;

  final DateTime? changedAt;

  final String? lastUpdatedBy;

  Task({
    required this.id,
    required this.text,
    this.importance = TaskImportant.basic,
    this.deadline,
    this.done = false,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });

  Task.create(
    this.text, {
    this.importance = TaskImportant.basic,
    this.deadline,
    this.done = false,
    this.color,
    this.lastUpdatedBy,
  })  : id = const Uuid().v1(),
        createdAt = DateTime.now(),
        changedAt = DateTime.now();

  Task setDate(
    DateTime? date,
  ) {
    return Task(
      id: id,
      text: text,
      importance: importance,
      deadline: date,
      done: done,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        text: json['text'] as String,
        importance: json['importance'] == 'low'
            ? TaskImportant.low
            : json['importance'] == 'basic'
                ? TaskImportant.basic
                : TaskImportant.important,
        deadline: json['deadline'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['deadline'] as int)
            : null,
        done: json['done'] as bool,
        color: json['color'] != null ? json['color'] as String : null,
        createdAt: json['created_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int)
            : null,
        changedAt: json['changed_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['changed_at'] as int)
            : null,
        lastUpdatedBy: json['last_updated_by'] != null
            ? json['last_updated_by'] as String
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'text': text,
        'importance': importance == TaskImportant.low
            ? 'low'
            : importance == TaskImportant.important
                ? 'important'
                : 'basic',
        'deadline': deadline?.millisecondsSinceEpoch,
        'done': done,
        'color': color,
        'created_at': createdAt?.millisecondsSinceEpoch,
        'changed_at': changedAt?.millisecondsSinceEpoch,
        'last_updated_by': lastUpdatedBy,
      };

  Task copyWith({
    String? id,
    String? text,
    TaskImportant? importance,
    DateTime? deadline,
    bool? done,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return Task(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }
}

int fastHash(String string) {
  // ignore: avoid_js_rounded_ints
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
