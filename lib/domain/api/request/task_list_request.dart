// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:note/domain/entity/task.dart';

class TaskListRequest {
  final List<Task> list;

  TaskListRequest({
    required this.list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskListRequest.fromMap(Map<String, dynamic> map) {
    return TaskListRequest(
      list: List<Task>.from(
        (map['list'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskListRequest.fromJson(String source) =>
      TaskListRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
