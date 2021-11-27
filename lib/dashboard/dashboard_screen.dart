import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/model/camera/camera.dart';
import '../../dashboard/bloc/camera_bloc.dart';
import '../../dashboard/bloc/camera_state.dart';
import '../../widgets/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case CameraFetchStatus.inProgress:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case CameraFetchStatus.failure:
            return const Center(
              child: Text(
                "Something went wrong :(",
              ),
            );
          case CameraFetchStatus.success:
            return CamerasList(
              camerasData: state.data,
            );
          default:
            return const Center(
              child: Text("Something went wrong"),
            );
        }
      },
    );
  }
}

class CamerasList extends StatelessWidget {
  const CamerasList({Key? key, required this.camerasData}) : super(key: key);

  final List<Camera> camerasData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView(
        children: [
          const Header(
            headerTitle: "Cameras",
          ),
          ...camerasData.map(
            (camera) => CameraView(
              cameraData: camera,
            ),
          )
        ],
      ),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView({
    Key? key,
    required this.cameraData,
  }) : super(key: key);

  final Camera cameraData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.network(
        cameraData.cameraStreamUrl ?? "",
        fit: BoxFit.fill,
      ),
    );
  }
}
