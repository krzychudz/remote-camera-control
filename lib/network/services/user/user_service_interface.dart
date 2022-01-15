import 'package:dio/dio.dart';

abstract class UserServiceInterface {
  Future<Response<dynamic>> registerUser(Map<String, dynamic> body);
  Future<String?> login(Map<String, dynamic> body);
}
