import '../../common/model/camera/camera.dart';

abstract class CameraRepositoryInterface {
  Future<List<Camera>> getCameras();
}
