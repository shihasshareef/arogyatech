import 'package:dio/dio.dart';

import '../common/environment.dart';


class DioClient {
  static Dio? _dio;

  static Future<Dio?> getClient() async {
    _dio ??= Dio(
      BaseOptions(
          baseUrl: ArogyaEnvironment.serverUrl,
          connectTimeout: const Duration(seconds: 120),
          receiveTimeout: const Duration(seconds: 120),
          contentType: 'application/json',
          responseType: ResponseType.json,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }),
    );
    return _dio;
  }
}
