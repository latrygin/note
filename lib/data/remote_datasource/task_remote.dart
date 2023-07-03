import 'package:device_info_plus/device_info_plus.dart';
import 'package:note/core/api/client/api_client.dart';
import 'package:note/core/api/client/url.dart';
import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/core/api/request/task_request.dart';
import 'package:note/core/api/response/task_list_response.dart';
import 'package:note/core/api/response/task_response.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/task_remote_impl.dart';

import 'revision_remote.dart';

class TaskRemote implements TaskRemoteDatasource {
  final _https = ApiClient();
  final _revision = RevisionRemote();
  final _device = DeviceInfoPlugin();
  @override
  Future<TaskListResponse> getAll() async {
    final response = await _https.get(URLs.getAll);
    final taskListResponse = TaskListResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
    await _revision.set(taskListResponse.revision);
    return taskListResponse;
  }

  @override
  Future<TaskResponse> delete(String id) async {
    final response = await _https.delete(URLs.delete(id));
    final taskResponse = TaskResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
    await _revision.set(taskResponse.revision);
    return taskResponse;
  }

  @override
  Future<TaskResponse> get(String id) async {
    final response = await _https.get(URLs.get(id));
    final taskResponse = TaskResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
    await _revision.set(taskResponse.revision);
    return taskResponse;
  }

  @override
  Future<TaskListResponse> patch(TaskListRequest request) async {
    final response = await _https.patch(
      URLs.patch,
      data: request.toMap(),
    );
    final taskListResponse = TaskListResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
    await _revision.set(taskListResponse.revision);
    return taskListResponse;
  }

  @override
  Future<TaskResponse> post(Task request) async {
    final deviceInfo = await _device.androidInfo;
    final task = request.copyWith(lastUpdatedBy: deviceInfo.id);
    final response = await _https.post(
      URLs.post,
      data: TaskRequest(task).toMap(),
    );
    final taskResponse = TaskResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
    await _revision.set(taskResponse.revision);
    return taskResponse;
  }

  @override
  Future<TaskResponse> put(Task request) async {
    final deviceInfo = await _device.androidInfo;
    final task = request.copyWith(
      lastUpdatedBy: deviceInfo.id,
      changedAt: DateTime.now(),
    );
    final response = await _https.put(
      URLs.put(request.id),
      data: TaskRequest(task).toMap(),
    );
    final taskResponse = TaskResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
    await _revision.set(taskResponse.revision);
    return taskResponse;
  }
}
