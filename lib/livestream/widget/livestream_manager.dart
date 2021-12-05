import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class LivestreamManager {
  LivestreamManager({
    required this.streamUrl,
    this.intervalMiliseconds = 30,
  });

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
      var response = await http.get(
        Uri.parse(streamUrl),
      );
      _streamController?.add(response.bodyBytes);
    } catch (e) {
      print('------Livestream exeption: ${e.toString()} -------');
    }
  }

  void dispose() {
    requestTimer?.cancel();
    _streamController?.close();
  }
}
