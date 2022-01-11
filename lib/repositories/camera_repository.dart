import 'dart:async';

import '../../network/services/camera/camera_service_interface.dart';
import '../repositories/camera_repository_interface.dart';
import '../../common/model/camera/camera.dart';
import 'package:app/extensions/response_extenstion.dart';

class CameraRepository implements CameraRepositoryInterface {
  CameraRepository(this.cameraService);

  final CameraServiceInterface cameraService;

  final _cameraStreamControler = StreamController<Camera>();

  @override
  Stream<Camera> get newCameraStream => _cameraStreamControler.stream;

  @override
  Future<List<Camera>> getCameras() {
    var mockedCameras = [
      Camera(cameraName: "Camera1", cameraId: "12345", cameraLocation: "Room1"),
      Camera(cameraName: "Camera2", cameraId: "12345", cameraLocation: "Room2")
    ];

    return Future.delayed(const Duration(seconds: 3), () => mockedCameras);
  }

  @override
  Future<void> installCamera({
    required String cameraId,
    required String cameraRoom,
    required String cameraName,
  }) async {
    var response = await cameraService.addCamera(
      {
        "id": cameraId,
        "title": cameraName,
        "description": cameraRoom,
      },
    );

    if (!response.isSuccessful()) {
      throw Exception(response.data?.statusMessage);
    }

    _cameraStreamControler.add(
      Camera.fromJson(
        {
          "cameraName": cameraName,
          "cameraLocation": cameraRoom,
          "cameraId": cameraId
        },
      ),
    );
  }

  @override
  void dispose() {
    _cameraStreamControler.close();
  }
}
