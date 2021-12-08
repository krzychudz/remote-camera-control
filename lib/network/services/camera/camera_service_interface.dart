import 'dart:typed_data';

abstract class CameraServiceInterface {
  Future<Uint8List> getCameraFrame(String cameraStreamUrl);
}
