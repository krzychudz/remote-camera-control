import 'dart:convert';

import 'package:app/network/api_client.dart';
import 'package:app/network/services/user/user_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/extensions/response_extenstion.dart';

@LazySingleton(as: UserServiceInterface)
class UserService implements UserServiceInterface {
  UserService(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<Response<ResponseBody>> registerUser(Map<String, dynamic> body) {
    return ApiClient().client.post<ResponseBody>("api/register", data: body);
  }

  @override
  Future<String?> login(Map<String, dynamic> body) async {
    // var response = await apiClient.client.post<String>(
    //   "api/token",
    //   data: body,
    // );

    // if (!response.isSuccessful()) {
    //   throw Exception(response.statusMessage);
    // }

    // return response.data;
    return '{"bearer": "TOKEN", "user": {"name": "John", "email": "john@gmail.com"}}';
  }
}
