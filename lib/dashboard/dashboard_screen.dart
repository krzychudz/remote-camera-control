import 'dart:typed_data';

import 'package:app/injection/injection.dart';
import 'package:app/network/services/camera/camera_service_interface.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../common/model/camera/camera.dart';
import '../../dashboard/bloc/camera_bloc.dart';
import '../../dashboard/bloc/camera_state.dart';
import '../../widgets/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, state) {
        switch (state.status) {
          case CameraFetchStatus.inProgress:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case CameraFetchStatus.failure:
            return Center(
              child: const Text(
                "general_error",
              ).tr(),
            );
          case CameraFetchStatus.success:
            if (state.data.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'camera_empty_info',
                    textAlign: TextAlign.center,
                  ).tr(),
                ),
              );
            }
            return CamerasList(
              camerasData: state.data,
            );
          default:
            return Center(
              child: const Text("general_error").tr(),
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
          Header(
            headerTitle: tr('cameras_header'),
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
    Navigator.of(context).pushNamed(
      "/livestream",
      arguments: cameraData.toJson(),
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
              child: CameraThumbnail(cameraData: cameraData),
            ),
            CameraHeader(
              cameraName: cameraData.cameraName ?? tr('unknown'),
              cameraLocation: cameraData.cameraLocation ?? tr('unknown'),
            )
          ],
        ),
      ),
    );
  }
}

class CameraThumbnail extends StatelessWidget {
  const CameraThumbnail({
    Key? key,
    required this.cameraData,
  }) : super(key: key);

  final Camera cameraData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
        future: getIt<CameraServiceInterface>().getCameraFrame(
          cameraData.cameraId ?? "",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CameraLoadingPlaceholder();
          }

          if (snapshot.hasError) {
            return const CameraLoadingPlaceholder();
          }

          return Image.memory(
            snapshot.data!,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              print(error);
              return const CameraLoadingPlaceholder();
            },
          );
        });
  }
}

class CameraLoadingPlaceholder extends StatelessWidget {
  const CameraLoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: Image.asset("assets/images/camera_placeholder.png"),
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
