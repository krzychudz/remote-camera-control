import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../camera_installation/bloc/camera_installation_cubit.dart';
import '../../camera_installation/bloc/camera_installation_state.dart';
import '../../common/snackbar/snackbar.dart';

class CameraInstallationScreen extends StatelessWidget {
  const CameraInstallationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add_camera_label').tr(),
      ),
      body: BlocListener<CameraInstallationCubit, CameraInstallationState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            context.showSnackbarMessage(
                message: tr('camera_added_succesfully'));
            Navigator.of(context).pop();
          }

          if (state.status.isSubmissionFailure) {
            context.showSnackbarMessage(
                message: tr('general_error'), isError: true);
          }
        },
        child: const CameraInstallationForm(),
      ),
    );
  }
}

class CameraInstallationForm extends StatelessWidget {
  const CameraInstallationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
  }) : super(key: key);

  void _onSubmitPressed(BuildContext context) {
    context.read<CameraInstallationCubit>().onSubmited();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraInstallationCubit, CameraInstallationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                key: const Key("newCameraForm_submit_elevatedButton"),
                onPressed: state.status.isValidated &&
                        !state.status.isSubmissionInProgress
                    ? () => _onSubmitPressed(context)
                    : null,
                child: state.status.isSubmissionInProgress
                    ? const CircularProgressIndicator()
                    : const Text(
                        'add_camera',
                      ).tr(),
              ),
            ),
          );
        });
  }
}

class CameraIdInput extends StatelessWidget {
  const CameraIdInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraInstallationCubit, CameraInstallationState>(
        buildWhen: (previous, current) => previous.cameraId != current.cameraId,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              onChanged: (newCameraId) => context
                  .read<CameraInstallationCubit>()
                  .onCameraIdChanged(newCameraId),
              key: const Key('newCameraForm_cameraIdInput_textField'),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: tr('camera_id'),
                errorText:
                    state.cameraId.invalid ? tr('camera_id_empty_error') : null,
              ),
            ),
          );
        });
  }
}

class CameraRoomInput extends StatelessWidget {
  const CameraRoomInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraInstallationCubit, CameraInstallationState>(
        buildWhen: (previous, current) =>
            previous.cameraRoom != current.cameraRoom,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              textInputAction: TextInputAction.done,
              onChanged: (newRoomValue) => context
                  .read<CameraInstallationCubit>()
                  .onCameraRoomChanged(newRoomValue),
              key: const Key('newCameraForm_cameraRoomInput_textField'),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: tr('room'),
                errorText:
                    state.cameraRoom.invalid ? tr('room_empty_error') : null,
              ),
            ),
          );
        });
  }
}

class CameraNameInput extends StatelessWidget {
  const CameraNameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraInstallationCubit, CameraInstallationState>(
        buildWhen: (previous, current) =>
            previous.cameraName != current.cameraName,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              onChanged: (newCameraNameValue) => context
                  .read<CameraInstallationCubit>()
                  .onCameraNameChanged(newCameraNameValue),
              key: const Key('newCameraForm_cameraNameInput_textField'),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: tr('camera_name'),
                errorText: state.cameraName.invalid
                    ? tr('camera_name_empty_error')
                    : null,
              ),
            ),
          );
        });
  }
}

class InstallationInfo extends StatelessWidget {
  const InstallationInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'camera_add_explanation',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
      ),
    ).tr();
  }
}
