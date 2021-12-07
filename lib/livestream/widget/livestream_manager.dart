import 'dart:async';
import 'dart:typed_data';

import 'package:app/network/services/camera_service.dart';

class LivestreamManager {
  LivestreamManager({
    required this.streamUrl,
    this.intervalMiliseconds = 30,
    required this.cameraService,
  });

  final CameraService cameraService;

  final String streamUrl;
  final int intervalMiliseconds;

  StreamController<Uint8List>? _streamController;
  Timer? requestTimer;

  get framesStream => _streamController?.stream;

  void start() {
    _streamController = StreamController();

    if (streamUrl.isEmpty) {
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
      var frameResponse = await cameraService.getCameraFrame(streamUrl);
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
