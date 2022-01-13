import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:app/cache/cache_keys.dart' as CacheKeys;

@Singleton()
class ApiClient {
  ApiClient() {
    _dio = createDio();
  }

  late Dio _dio;
  Dio get client => _dio;

  Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:8000/",
        receiveTimeout: 15000,
        connectTimeout: 15000,
        sendTimeout: 15000,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var storage = await Hive.openBox(CacheKeys.tokenBoxName);
          String? token = storage.get(CacheKeys.tokenKey);
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          handler.next(options);
        },
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var storage = await Hive.openBox(CacheKeys.baseUrlBoxName);
        String? baseUrl = storage.get(CacheKeys.baseUrlKey);
        options.baseUrl = baseUrl ?? "";
        handler.next(options);
      },
    ));

    dio.interceptors.add(LogInterceptor(responseBody: false));

    return dio;
  }
}
