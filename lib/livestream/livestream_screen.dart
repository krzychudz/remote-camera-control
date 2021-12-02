import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:app/common/model/camera/camera.dart';
import 'package:flutter/material.dart';

class LivestreamScreen extends StatefulWidget {
  const LivestreamScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final Camera? camera;

  @override
  State<LivestreamScreen> createState() => _LivestreamScreenState();
}

class _LivestreamScreenState extends State<LivestreamScreen> {
  StreamController<Uint8List>? streamController;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    timer = Timer.periodic(Duration.zero, (Timer t) => _refresh());
  }

  @override
  void dispose() {
    timer?.cancel();
    streamController?.close();
    super.dispose();
  }

  void _refresh() async {
    var response = await http.get(
      Uri.parse("https://picsum.photos/200/300"),
    );
    streamController?.add(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livestream ${widget.camera?.cameraName}'),
      ),
      body: SizedBox.expand(
        child: StreamBuilder(
            stream: streamController?.stream,
            builder: (context, snapshot) {
              return Image.memory(
                snapshot.data as Uint8List,
                fit: BoxFit.fill,
                gaplessPlayback: true,
              );
            }),
      ),
    );
  }
}
