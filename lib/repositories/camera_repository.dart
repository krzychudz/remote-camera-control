import '../../network/services/camera/camera_service_interface.dart';
import '../repositories/camera_repository_interface.dart';
import '../../common/model/camera/camera.dart';

class CameraRepository implements CameraRepositoryInterface {
  CameraRepository(this.cameraService);

  final CameraServiceInterface cameraService;

  @override
  Future<List<Camera>> getCameras() {
    var mockedCameras = [
      Camera(
          cameraName: "Camera1",
          cameraStreamUrl: "http://localhost:3000/frames/frame.jpg",
          cameraLocation: "Room1"),
      Camera(
          cameraName: "Camera2",
          cameraStreamUrl: "https://picsum.photos/id/1/200/300",
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
