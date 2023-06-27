import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import 'task_importance.dart';

part 'task.g.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      text: map['text'] as String,
      importance: map['importance'] == 'low'
          ? TaskImportant.low
          : map['importance'] == 'basic'
              ? TaskImportant.basic
              : TaskImportant.important,
      deadline: map['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int)
          : null,
      done: map['done'] as bool,
      color: map['color'] != null ? map['color'] as String : null,
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : null,
      changedAt: map['changed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['changed_at'] as int)
          : null,
      lastUpdatedBy: map['last_updated_by'] != null
          ? map['last_updated_by'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

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
