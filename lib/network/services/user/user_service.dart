import 'package:app/network/api_client.dart';
import 'package:app/network/services/user/user_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserServiceInterface)
class UserService implements UserServiceInterface {
  UserService(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<Response<ResponseBody>> registerUser(Map<String, dynamic> body) {
    return ApiClient().client.post<ResponseBody>("api/register", data: body);
  }
}
