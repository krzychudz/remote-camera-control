import '../repositories/camera_repository_interface.dart';

import '../../common/model/camera/camera.dart';

class CameraRepository implements CameraRepositoryInterface {
  @override
  Future<List<Camera>> getCameras() {
    var mockedCameras = [
      Camera(
          cameraName: "Camera1",
          cameraStreamUrl: "http://localhost:3000/frames/frame.jpg",
          cameraLocation: "Room1"),
      Camera(
          cameraName: "Camera2",
          cameraStreamUrl: "http://192.168.0.21:3000/frames/frame.jpg",
          cameraLocation: "Room2")
    ];

    return Future.delayed(const Duration(seconds: 3), () => mockedCameras);
  }

  @override
  Future<bool> installCamera({
    required String cameraId,
    required String cameraRoom,
    required String cameraName,
  }) {
    return Future.delayed(const Duration(seconds: 3), () => true);
  }
}
