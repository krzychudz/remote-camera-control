import 'package:app/common/model/camera/camera.dart';
import 'package:app/livestream/livestream_screen.dart';
import 'package:flutter/material.dart';

class LivestreamPage extends StatelessWidget {
  const LivestreamPage({Key? key, required this.cameraData}) : super(key: key);

  static Route route(Camera camera) {
    return MaterialPageRoute<void>(
      builder: (_) => LivestreamPage(
        cameraData: camera,
      ),
    );
  }

  final Camera cameraData;

  @override
  Widget build(BuildContext context) {
    return LivestreamScreen(camera: cameraData);
  }
}
