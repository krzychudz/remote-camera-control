import '../../common/model/camera/camera.dart';

abstract class CameraRepositoryInterface {
  Future<List<Camera>> getCameras();
  Future<void> installCamera({
    required String cameraId,
    required String cameraRoom,
    required String cameraName,
  });

  Stream<Camera> get newCameraStream;
  void dispose();
}
