import 'package:app/dashboard/bloc/camera_bloc.dart';
import 'package:app/repositories/camera_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/dashboard_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CameraCubit>(
      create: (ctx) => CameraCubit(
        cameraRepository: RepositoryProvider.of<CameraRepository>(context),
      )..onCameraFetched(),
      child: DashboardScreen(),
    );
  }
}
