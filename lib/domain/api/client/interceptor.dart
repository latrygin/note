import 'package:dio/dio.dart';
import 'package:note/domain/provider/revision/revision_provider.dart';
import 'package:note/utils/exception/bad_request_exception.dart';
import 'package:note/utils/exception/not_found_exception.dart';
import 'package:note/utils/exception/server_error_exception.dart';
import 'package:note/utils/exception/unauthorized_exception.dart';

import 'token.dart';

class AuthInterceptor extends Interceptor {
  final _revision = RevisionProvider();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Content-Type'] = 'application/json; charset=utf-8';
    options.headers['Authorization'] = 'Bearer ${Token.token}';
    options.headers['X-Last-Known-Revision'] = _revision.get();
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    switch (err.response?.statusCode) {
      case 200:
        break;
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorizedException();
      case 404:
        throw NotFoundException();
      case 500:
        throw ServerErrorException();
      default:
        throw Exception('Какого хрена ${err.response?.statusCode}?');
    }
    super.onError(err, handler);
  }
}
