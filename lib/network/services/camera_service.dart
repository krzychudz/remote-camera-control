import 'dart:typed_data';

import '../../network/api_client.dart';

class CameraService {
  static CameraService? _instance;

  factory CameraService() => _instance ??= CameraService._internal();

  CameraService._internal();

  Future<Uint8List> getCameraFrame(String cameraStreamUrl) async {
    var response = await ApiClient().client.get(cameraStreamUrl);
    return response.data as Uint8List;
  }
}
