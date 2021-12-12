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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const InstallationInfo(),
            const SizedBox(
              height: 32,
            ),
            const CameraIdInput(),
            const SizedBox(
              height: 16,
            ),
            const CameraNameInput(),
            const SizedBox(
              height: 16,
            ),
            const CameraRoomInput(),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: Container(
                child: const SubmitButton(),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          key: Key("newCameraForm_submit_elevatedButton"),
          onPressed: null,
          child: Text(
            "Add camera",
          ),
        ),
      ),
    );
  }
}

class CameraIdInput extends StatelessWidget {
  const CameraIdInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        textInputAction: TextInputAction.next,
        onChanged: (rePassword) => null,
        key: const Key('newCameraForm_cameraIdInput_textField'),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Camera ID',
          errorText: null,
        ),
      ),
    );
  }
}

class CameraRoomInput extends StatelessWidget {
  const CameraRoomInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        textInputAction: TextInputAction.done,
        onChanged: (rePassword) => null,
        key: const Key('newCameraForm_cameraRoomInput_textField'),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Room',
          errorText: null,
        ),
      ),
    );
  }
}

class CameraNameInput extends StatelessWidget {
  const CameraNameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        textInputAction: TextInputAction.next,
        onChanged: (rePassword) => null,
        key: const Key('newCameraForm_cameraNameInput_textField'),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Camera Name',
          errorText: null,
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
