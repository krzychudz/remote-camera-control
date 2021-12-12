import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '..//bloc/validators/camera_id.dart';
import '../bloc/validators/camera_name.dart';
import '../bloc/validators/camera_room.dart';

class CameraInstallationState extends Equatable {
  const CameraInstallationState({
    this.status = FormzStatus.pure,
    this.cameraId = const CameraId.pure(),
    this.cameraName = const CameraName.pure(),
    this.cameraRoom = const CameraRoom.pure(),
  });

  final CameraId cameraId;
  final CameraName cameraName;
  final CameraRoom cameraRoom;
  final FormzStatus status;

  CameraInstallationState copyWith({
    CameraId? cameraId,
    CameraName? cameraName,
    CameraRoom? cameraRoom,
    FormzStatus? status,
  }) {
    return CameraInstallationState(
      cameraId: cameraId ?? this.cameraId,
      cameraName: cameraName ?? this.cameraName,
      cameraRoom: cameraRoom ?? this.cameraRoom,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [cameraId, cameraName, cameraRoom, status];
}
