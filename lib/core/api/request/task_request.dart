import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/entity/task.dart';

part 'task_request.freezed.dart';
part 'task_request.g.dart';

@freezed
sealed class TaskRequest with _$TaskRequest {
  const factory TaskRequest({
    required Task element,
  }) = _TaskRequest;

  factory TaskRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskRequestFromJson(json);
}
