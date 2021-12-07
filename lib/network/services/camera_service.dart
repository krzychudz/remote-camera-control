import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../network/api_client.dart';

class CameraService {
  static CameraService? _instance;

  factory CameraService() => _instance ??= CameraService._internal();

  CameraService._internal();

  Future<Uint8List> getCameraFrame(String cameraStreamUrl) async {
    var response = await ApiClient().client.get<List<int>>(
          cameraStreamUrl,
          options: Options(responseType: ResponseType.bytes),
        );
    return Uint8List.fromList(response.data!);
  }
}
