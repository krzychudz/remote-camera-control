import 'package:dio/dio.dart';

extension ResponseValidation on Response {
  bool isSuccessful() {
    return statusCode != null && (statusCode! >= 200 && statusCode! <= 299);
  }
}
