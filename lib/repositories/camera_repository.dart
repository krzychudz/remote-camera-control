import '../repositories/camera_repository_interface.dart';

import '../../common/model/camera/camera.dart';

class CameraRepository implements CameraRepositoryInterface {
  @override
  Future<List<Camera>> getCameras() {
    var mockedCameras = [
      Camera(
          cameraName: "Camera1",
          cameraStreamUrl: "https://picsum.photos/200/300",
          cameraLocation: "Room1"),
      Camera(
          cameraName: "Camera2",
          cameraStreamUrl: "https://picsum.photos/200/300",
          cameraLocation: "Room2")
    ];

    return Future.delayed(const Duration(seconds: 3), () => mockedCameras);
  }
}
