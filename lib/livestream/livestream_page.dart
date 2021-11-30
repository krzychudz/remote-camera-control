import 'package:app/livestream/livestream_screen.dart';
import 'package:flutter/material.dart';

class LivestreamPage extends StatelessWidget {
  const LivestreamPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => LivestreamPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LivestreamScreen();
  }
}
