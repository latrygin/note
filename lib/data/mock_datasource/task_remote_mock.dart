import 'package:note/core/api/request/task_list_request.dart';
import 'package:note/core/api/response/task_list_response.dart';
import 'package:note/core/api/response/task_response.dart';
import 'package:note/core/exception/exception.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/repository/task_remote_impl.dart';

class TaskRemoteMock implements TaskRemoteDatasourceImpl {
  final List<Task> _tasks = <Task>[];

  @override
  Future<TaskResponse> delete(String id) {
    for (final element in _tasks) {
      if (element.id == id) {
        _tasks.remove(element);
        return Future.value(
          TaskResponse(
            status: 'ok',
            element: element,
            revision: 1,
          ),
        );
      }
    }
    throw NotFoundException();
  }

  @override
  Future<TaskResponse> get(String id) {
    for (final element in _tasks) {
      if (element.id == id) {
        return Future.value(
          TaskResponse(
            status: 'ok',
            element: element,
            revision: 1,
          ),
        );
      }
    }
    throw NotFoundException();
  }

  @override
  Future<TaskListResponse> getAll() {
    return Future.value(
      TaskListResponse(
        status: 'ok',
        revision: 1,
        list: _tasks,
      ),
    );
  }

  @override
  Future<TaskListResponse> patch(TaskListRequest request) {
    _tasks
      ..clear()
      ..addAll(request.list);
    return Future.value(
      TaskListResponse(
        status: 'ok',
        revision: 1,
        list: request.list,
      ),
    );
  }

  @override
  Future<TaskResponse> post(Task request) {
    _tasks.add(request);
    return Future.value(
      TaskResponse(
        status: 'ok',
        element: request,
        revision: 1,
      ),
    );
  }

  @override
  Future<TaskResponse> put(Task request) {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == request.id) {
        _tasks[i] = request;
        return Future.value(
          TaskResponse(
            status: 'ok',
            element: request,
            revision: 1,
          ),
        );
      }
    }
    throw NotFoundException();
  }
}
