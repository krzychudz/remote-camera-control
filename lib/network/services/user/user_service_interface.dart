import 'package:dio/dio.dart';

abstract class UserServiceInterface {
  Future<Response<ResponseBody>> registerUser(Map<String, dynamic> body);
}
