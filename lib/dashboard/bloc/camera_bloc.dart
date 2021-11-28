import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/bloc/camera_state.dart';
import '../../repositories/camera_repository.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit({
    required CameraRepository cameraRepository,
  })  : _cameraRepository = cameraRepository,
        super(const CameraState());

  final CameraRepository _cameraRepository;

  void onCameraFetched() async {
    emit(
      state.copyWith(status: CameraFetchStatus.inProgress),
    );

    try {
      var cameras = await _cameraRepository.getCameras();
      emit(
        state.copyWith(
          status: CameraFetchStatus.success,
          data: cameras,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(status: CameraFetchStatus.failure),
      );
    }
  }
}
