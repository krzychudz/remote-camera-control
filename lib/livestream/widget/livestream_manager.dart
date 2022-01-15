import 'dart:async';
import 'dart:typed_data';
import 'package:app/network/services/camera/camera_service_interface.dart';

class LivestreamManager {
  LivestreamManager({
    required this.cameraId,
    this.intervalMiliseconds = 30,
    required this.cameraService,
  });

  final CameraServiceInterface cameraService;

  final String cameraId;
  final int intervalMiliseconds;

  StreamController<Uint8List>? _streamController;
  Timer? requestTimer;

  get framesStream => _streamController?.stream;

  void start() {
    _streamController = StreamController();

    if (cameraId.isEmpty) {
      _streamController?.addError(
        Exception("URL cannot be null"),
      );
    } else {
      requestTimer = Timer.periodic(
        Duration(
          milliseconds: intervalMiliseconds,
        ),
        (Timer t) => _getNewFrame(),
      );
    }
  }

  void _getNewFrame() async {
    try {
      var frameResponse = await cameraService.getCameraFrame(cameraId);
      _streamController?.add(frameResponse);
    } catch (e) {
      print('------Livestream exeption: ${e.toString()} -------');
    }
  }

  void dispose() {
    requestTimer?.cancel();
    _streamController?.close();
  }
}
