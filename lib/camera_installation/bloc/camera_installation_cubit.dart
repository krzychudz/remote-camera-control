import 'package:app/repositories/camera_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/camera_installation_state.dart';
import '../bloc/validators/camera_name.dart';
import '../bloc/validators/camera_room.dart';
import '../bloc/validators/camera_id.dart';

class CameraInstallationCubit extends Cubit<CameraInstallationState> {
  CameraInstallationCubit({
    required CameraRepository cameraRepository,
  })  : _cameraRepository = cameraRepository,
        super(
          const CameraInstallationState(),
        );

  final CameraRepository _cameraRepository;

  void onCameraIdChanged(String newCameraIdState) {
    final cameraId = CameraId.dirty(newCameraIdState);
    emit(
      state.copyWith(
        cameraId: cameraId,
        status: Formz.validate(
          [cameraId, state.cameraName, state.cameraRoom],
        ),
      ),
    );
  }

  void onCameraNameChanged(String newCameraName) {
    final cameraName = CameraName.dirty(newCameraName);
    emit(
      state.copyWith(
        cameraName: cameraName,
        status: Formz.validate(
          [cameraName, state.cameraRoom, state.cameraId],
        ),
      ),
    );
  }

  void onCameraRoomChanged(String newCameraRoomState) {
    final cameraRoom = CameraRoom.dirty(newCameraRoomState);
    emit(
      state.copyWith(
        cameraRoom: cameraRoom,
        status: Formz.validate(
          [cameraRoom, state.cameraId, state.cameraName],
        ),
      ),
    );
  }

  void onSubmited() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _cameraRepository.installCamera(
          cameraId: state.cameraId.value,
          cameraName: state.cameraName.value,
          cameraRoom: state.cameraRoom.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
