import '../../common/model/camera/camera.dart';

abstract class CameraRepositoryInterface {
  Future<List<Camera>> getCameras();
  Future<bool> installCamera({
    required String cameraId,
    required String cameraRoom,
    required String cameraName,
  });
}
