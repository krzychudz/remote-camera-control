import 'dart:async';

import '../../network/services/camera/camera_service_interface.dart';
import '../repositories/camera_repository_interface.dart';
import '../../common/model/camera/camera.dart';
import 'package:app/extensions/response_extenstion.dart';

class CameraRepository implements CameraRepositoryInterface {
  CameraRepository(this.cameraService);

  final CameraServiceInterface cameraService;

  final _cameraStreamControler = StreamController<Camera>.broadcast();

  @override
  Stream<Camera> get newCameraStream => _cameraStreamControler.stream;

  @override
  Future<List<Camera>> getCameras() async {
    var camerasResponse = await cameraService.getCameras();
    return camerasResponse;
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
          "title": cameraName,
          "description": cameraRoom,
          "id": cameraId,
        },
      ),
    );
  }

  @override
  void dispose() {
    _cameraStreamControler.close();
  }
}
