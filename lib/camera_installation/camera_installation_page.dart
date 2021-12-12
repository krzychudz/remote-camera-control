import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../camera_installation/bloc/camera_installation_cubit.dart';
import '../camera_installation/camera_installtion_screen.dart';
import '/repositories/camera_repository.dart';

class CameraInstallationPage extends StatelessWidget {
  const CameraInstallationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CameraInstallationCubit(
        cameraRepository: RepositoryProvider.of<CameraRepository>(context),
      ),
      child: const CameraInstallationScreen(),
    );
  }
}
