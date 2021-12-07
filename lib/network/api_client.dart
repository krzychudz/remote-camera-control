import 'package:dio/dio.dart';

class ApiClient {
  late final _dio = createDio();

  ApiClient._internal();

  static ApiClient? _instance;

  factory ApiClient() => _instance ??= ApiClient._internal();

  Dio get client => _dio;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: "tmp",
        receiveTimeout: 15000,
        connectTimeout: 15000,
        sendTimeout: 15000,
      ),
    );

    return dio;
  }
}
