import 'package:dio/dio.dart';

class ApiClient {
  late final _dio = createDio();

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

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
