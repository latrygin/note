import 'dart:convert';

import 'package:note/domain/entity/task.dart';

class TaskListResponse {
  final String status;
  final int revision;
  final List<Task> list;

  TaskListResponse({
    required this.status,
    required this.revision,
    required this.list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'revision': revision,
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskListResponse.fromMap(Map<String, dynamic> map) {
    return TaskListResponse(
      status: map['status'] as String,
      revision: map['revision'] as int,
      list: List<Task>.from(
        (map['list'] as List<dynamic>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskListResponse.fromJson(String source) =>
      TaskListResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
