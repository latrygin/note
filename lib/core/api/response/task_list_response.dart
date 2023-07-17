import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/entity/task.dart';

part 'task_list_response.freezed.dart';
part 'task_list_response.g.dart';

@freezed
sealed class TaskListResponse with _$TaskListResponse {
  const factory TaskListResponse({
    required String status,
    required int revision,
    required List<Task> list,
  }) = _TaskListResponse;

  factory TaskListResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskListResponseFromJson(json);
}
