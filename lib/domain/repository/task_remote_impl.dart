import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/core/api/response/task_list_response.dart';
import 'package:note/core/api/response/task_response.dart';
import 'package:note/domain/entity/task.dart';

abstract class TaskRemoteDatasource {
  Future<TaskListResponse> getAll();
  Future<TaskResponse> get(String id);
  Future<TaskResponse> put(Task request);
  Future<TaskResponse> delete(String id);
  Future<TaskResponse> post(Task request);
  Future<TaskListResponse> patch(TaskListRequest request);
}
