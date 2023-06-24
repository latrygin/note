import 'package:dio/dio.dart';
import 'package:note/utils/logger/logger.dart';

import 'interceptor.dart';

class ApiClient {
  late Dio _https;

  ApiClient() {
    _https = Dio();
    _https.interceptors.add(AuthInterceptor());
  }

  Future<Response<Map<String, dynamic>>> get(String path) async {
    try {
      logger.v('GET: $path');
      final response = await _https.get<Map<String, dynamic>>(path);
      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  Future<Response<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      logger
        ..v('POST: $path')
        ..v(data);
      final response = await _https.post<Map<String, dynamic>>(
        path,
        data: data,
      );

      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  Future<Response<Map<String, dynamic>>> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      logger
        ..v('PUT: $path')
        ..v(data);
      final response = await _https.put<Map<String, dynamic>>(
        path,
        data: data,
      );
      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  Future<Response<Map<String, dynamic>>> patch(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      logger
        ..v('PATCH: $path')
        ..v(data);
      final response = await _https.patch<Map<String, dynamic>>(
        path,
        data: data,
      );
      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  Future<Response<Map<String, dynamic>>> delete(String path) async {
    try {
      logger.v('DELETE: $path');
      final response = await _https.delete<Map<String, dynamic>>(path);
      logger.v(response.data);
      return response;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }
}
