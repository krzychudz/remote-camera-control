import 'dart:typed_data';

import 'package:app/network/services/camera/camera_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../api_client.dart';

@LazySingleton(as: CameraServiceInterface)
class CameraService extends CameraServiceInterface {
  CameraService(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<Uint8List> getCameraFrame(String cameraStreamUrl) async {
    var response = await apiClient.client.get<List<int>>(
      cameraStreamUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  }
}
