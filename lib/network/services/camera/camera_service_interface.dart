import 'dart:typed_data';

import 'package:app/common/model/camera/camera.dart';
import 'package:dio/dio.dart';

abstract class CameraServiceInterface {
  Future<Uint8List> getCameraFrame(String cameraStreamUrl);
  Future<Response<dynamic>> addCamera(Map<String, String> body);
  Future<List<Camera>> getCameras();
}
