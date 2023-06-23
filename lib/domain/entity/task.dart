import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'task_importance.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final TaskImportant importance;

  @HiveField(3)
  final DateTime? deadline;

  @HiveField(4)
  final bool done;

  @HiveField(5)
  final String? color;

  @HiveField(6)
  final DateTime? createdAt;

  @HiveField(7)
  final DateTime? changedAt;

  @HiveField(8)
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
