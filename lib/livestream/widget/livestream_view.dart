import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../../livestream/widget/livestream_manager.dart';
import '../../network/services/camera_service.dart';

class LivestreamView extends StatefulWidget {
  const LivestreamView({
    Key? key,
    this.debugMode,
    required this.framesUrl,
  }) : super(key: key);

  final String? framesUrl;
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
    livestreamManager = LivestreamManager(
      streamUrl: widget.framesUrl ?? "",
      cameraService: CameraService(),
    )..start();
  }

  @override
  void dispose() {
    livestreamManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: StreamBuilder(
          stream: livestreamManager?.framesStream,
          builder: (context, snapshot) {
            if (widget.debugMode == true) {
              _calculateFPS();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
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
          }),
    );
  }

  void _calculateFPS() {
    double fps =
        1 / ((DateTime.now().microsecondsSinceEpoch - previousFrameTime));
    print('FPS: ${fps * 1000000}');
    previousFrameTime = DateTime.now().microsecondsSinceEpoch;
  }
}
