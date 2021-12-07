import 'dart:typed_data';

import 'package:app/network/services/camera/camera_service_interface.dart';
import 'package:dio/dio.dart';

import '../../api_client.dart';

class CameraService extends CameraServiceInterface {
  static CameraService? _instance;

  factory CameraService() => _instance ??= CameraService._internal();

  CameraService._internal();

  @override
  Future<Uint8List> getCameraFrame(String cameraStreamUrl) async {
    var response = await ApiClient().client.get<List<int>>(
          cameraStreamUrl,
          options: Options(responseType: ResponseType.bytes),
        );
    return Uint8List.fromList(response.data!);
  }
}
