import 'dart:convert';

import 'package:note/domain/entity/task.dart';

class TaskRequest {
  final Task element;

  TaskRequest(
    this.element,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'element': element.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
