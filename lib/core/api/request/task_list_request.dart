import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/entity/task.dart';

part 'task_list_request.freezed.dart';
part 'task_list_request.g.dart';

@freezed
sealed class TaskListRequest with _$TaskListRequest {
  const factory TaskListRequest({
    required List<Task> list,
  }) = _TaskRequest;

  factory TaskListRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskListRequestFromJson(json);
}
