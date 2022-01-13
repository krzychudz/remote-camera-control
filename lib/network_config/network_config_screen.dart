import 'package:app/repositories/network_config/network_config_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/snackbar/snackbar.dart';

class NetworkConfigScreen extends StatefulWidget {
  NetworkConfigScreen({Key? key}) : super(key: key);

  @override
  State<NetworkConfigScreen> createState() => _NetworkConfigScreenState();
}

class _NetworkConfigScreenState extends State<NetworkConfigScreen> {
  final TextEditingController _ipAddressTextEditingController =
      TextEditingController();

  final TextEditingController _portTextEditingController =
      TextEditingController();

  void setBaseIp(BuildContext context) async {
    var ip = _ipAddressTextEditingController.text;
    var port = _portTextEditingController.text.isNotEmpty
        ? _portTextEditingController.text
        : null;

    await RepositoryProvider.of<NetworkConfigRepository>(context)
        .setBaseUrl(ip, port);

    context.showSnackbarMessage(
      message: "Configuration has been saved",
    );
  }

  @override
  void initState() {
    _initFields();
    super.initState();
  }

  void _initFields() {
    Future.delayed(Duration.zero).then((value) async {
      var networkConfiguration =
          await RepositoryProvider.of<NetworkConfigRepository>(context)
              .getIpAndPort();

      print(networkConfiguration);

      if (networkConfiguration != null) {
        _ipAddressTextEditingController.text = networkConfiguration["ip"] ?? "";
        _portTextEditingController.text = networkConfiguration["port"] ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network Configuration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Provide the base station configuration",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            IpFormField(
              textEditingController: _ipAddressTextEditingController,
            ),
            const SizedBox(
              height: 8,
            ),
            PortFormField(
              textEditingController: _portTextEditingController,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                key:
                    const Key("networkConfigurationForm_submit_elevatedButton"),
                onPressed: () => setBaseIp(context),
                child: const Text(
                  "Save",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IpFormField extends StatelessWidget {
  const IpFormField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      textInputAction: TextInputAction.next,
      onChanged: (ipAddress) => {},
      key: const Key('networkConfigurationForm_IpInput_textField'),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "IP",
      ),
    );
  }
}

class PortFormField extends StatelessWidget {
  const PortFormField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      textInputAction: TextInputAction.next,
      key: const Key('networkConfigurationForm_PortInput_textField'),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Port",
      ),
    );
  }
}
