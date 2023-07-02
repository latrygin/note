import 'dart:convert';

import 'package:note/domain/entity/task.dart';

class TaskResponse {
  final String status;
  final int revision;
  final Task element;

  TaskResponse({
    required this.status,
    required this.revision,
    required this.element,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'revision': revision,
      'element': element.toMap(),
    };
  }

  factory TaskResponse.fromMap(Map<String, dynamic> map) {
    return TaskResponse(
      status: map['status'] as String,
      revision: map['revision'] as int,
      element: Task.fromMap(map['element'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskResponse.fromJson(String source) =>
      TaskResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
