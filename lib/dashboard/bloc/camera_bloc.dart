import 'dart:async';

import 'package:app/common/model/camera/camera.dart';
import 'package:app/repositories/camera_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/bloc/camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit({
    required CameraRepositoryInterface cameraRepository,
  })  : _cameraRepository = cameraRepository,
        super(const CameraState()) {
    _newCameraSubscription =
        _cameraRepository.newCameraStream.listen((newCamera) {
      _onNewCameraAdded(newCamera);
    });
  }

  final CameraRepositoryInterface _cameraRepository;
  late final StreamSubscription _newCameraSubscription;

  void _onNewCameraAdded(Camera newCamera) async {
    emit(
      state.copyWith(
        data: [...state.data, newCamera],
      ),
    );
  }

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

  @override
  Future<void> close() {
    _newCameraSubscription.cancel();
    _cameraRepository.dispose();
    return super.close();
  }
}
