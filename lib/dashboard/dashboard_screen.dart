import 'package:app/livestream/livestream_page.dart';
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

  void _onCameraClicked(Camera cameraInfo, BuildContext context) {
    Navigator.of(context).push(
      LivestreamPage.route(cameraInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onCameraClicked(cameraData, context),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                cameraData.cameraStreamUrl ?? "",
                fit: BoxFit.fill,
              ),
            ),
            CameraHeader(
              cameraName: cameraData.cameraName ?? "Unknown",
              cameraLocation: cameraData.cameraLocation ?? "Unknown",
            )
          ],
        ),
      ),
    );
  }
}

class CameraHeader extends StatelessWidget {
  const CameraHeader({
    Key? key,
    required this.cameraName,
    required this.cameraLocation,
  }) : super(key: key);

  final String cameraName;
  final String cameraLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: double.infinity,
      height: 40,
      color: const Color(0xAADAE0E3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cameraName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3D4548),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.pin_drop),
              ),
              Text(
                cameraLocation,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3D4548),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
