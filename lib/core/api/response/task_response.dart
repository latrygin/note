import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/entity/task.dart';

part 'task_response.freezed.dart';
part 'task_response.g.dart';

@freezed
sealed class TaskResponse with _$TaskResponse {
  const factory TaskResponse({
    required String status,
    required int revision,
    required Task element,
  }) = _TaskResponse;

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);
}
