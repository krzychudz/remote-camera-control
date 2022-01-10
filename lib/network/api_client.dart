import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ApiClient {
  late final _dio = createDio();
  Dio get client => _dio;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:8000/",
        receiveTimeout: 15000,
        connectTimeout: 15000,
        sendTimeout: 15000,
      ),
    );

    return dio;
  }
}
