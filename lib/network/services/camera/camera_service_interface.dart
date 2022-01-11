import 'dart:typed_data';

import 'package:dio/dio.dart';

abstract class CameraServiceInterface {
  Future<Uint8List> getCameraFrame(String cameraStreamUrl);
  Future<Response<ResponseBody>> addCamera(Map<String, String> body);
}
