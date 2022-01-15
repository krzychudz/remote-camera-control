import 'dart:convert';
import 'dart:typed_data';

import 'package:app/common/model/camera/camera.dart';
import 'package:app/network/services/camera/camera_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/extensions/response_extenstion.dart';

import '../../api_client.dart';

@LazySingleton(as: CameraServiceInterface)
class CameraService implements CameraServiceInterface {
  CameraService(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<Uint8List> getCameraFrame(String cameraId) async {
    var response = await apiClient.client.get<List<int>>(
      "api/cameras/$cameraId",
      options:
          Options(responseType: ResponseType.bytes, contentType: "image/jpeg"),
    );
    return Uint8List.fromList(response.data!);
  }

  @override
  Future<Response<dynamic>> addCamera(Map<String, String> body) async {
    return await apiClient.client.post<dynamic>("api/cameras", data: body);
  }

  @override
  Future<List<Camera>> getCameras() async {
    var response = await apiClient.client.get<String>("api/cameras");

    if (!response.isSuccessful()) {
      throw Exception(response.statusMessage);
    }

    List camerasRaw = json.decode(response.data.toString());

    return camerasRaw
        .map((e) => Camera.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
