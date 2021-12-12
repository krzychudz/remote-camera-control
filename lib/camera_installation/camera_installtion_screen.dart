import 'package:flutter/material.dart';

class CameraInstallationScreen extends StatelessWidget {
  const CameraInstallationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add camera"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InstallationInfo(),
          ],
        ),
      ),
    );
  }
}

class InstallationInfo extends StatelessWidget {
  const InstallationInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Provide necessary information to install your camera. You will find camera ID on the device",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
