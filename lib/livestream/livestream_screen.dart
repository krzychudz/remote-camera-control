import 'package:app/common/model/camera/camera.dart';
import 'package:app/livestream/widget/livestream_view.dart';
import 'package:flutter/material.dart';

class LivestreamScreen extends StatelessWidget {
  const LivestreamScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final Camera? camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livestream ${camera?.cameraName}'),
      ),
      body: LivestreamView(
        framesUrl: camera?.cameraStreamUrl,
        debugMode: true,
      ),
    );
  }
}
