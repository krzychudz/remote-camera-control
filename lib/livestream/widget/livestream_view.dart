import 'package:app/common/model/camera/camera.dart';
import 'package:app/injection/injection.dart';
import 'package:app/network/services/camera/camera_service_interface.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../../livestream/widget/livestream_manager.dart';

class LivestreamView extends StatefulWidget {
  const LivestreamView({
    Key? key,
    this.debugMode,
    required this.camera,
  }) : super(key: key);

  final Camera? camera;
  final bool? debugMode;

  @override
  _LivestreamViewState createState() => _LivestreamViewState();
}

class _LivestreamViewState extends State<LivestreamView> {
  LivestreamManager? livestreamManager;
  int previousFrameTime = 0;

  @override
  void initState() {
    super.initState();
    _startStream();
  }

  void _startStream() async {
    var framesUrl = await widget.camera?.cameraStreamUrl;

    setState(() {
      livestreamManager = LivestreamManager(
        streamUrl: framesUrl ?? "",
        cameraService: getIt<CameraServiceInterface>(),
      )..start();
    });
  }

  @override
  void dispose() {
    livestreamManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: StreamBuilder<Uint8List>(
        stream: livestreamManager?.framesStream,
        builder: (context, snapshot) {
          if (widget.debugMode == true) {
            _calculateFPS();
          }

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          return Image.memory(
            snapshot.data as Uint8List,
            fit: BoxFit.fill,
            gaplessPlayback: true,
          );
        },
      ),
    );
  }

  void _calculateFPS() {
    double fps =
        1 / ((DateTime.now().microsecondsSinceEpoch - previousFrameTime));
    print('FPS: ${fps * 1000000}');
    previousFrameTime = DateTime.now().microsecondsSinceEpoch;
  }
}
