import 'package:app/common/model/camera/camera.dart';
import 'package:equatable/equatable.dart';

enum CameraFetchStatus { inProgress, success, failure, empty }

class CameraState extends Equatable {
  const CameraState({
    this.status = CameraFetchStatus.empty,
    this.data = const [],
  });

  final CameraFetchStatus status;
  final List<Camera> data;

  CameraState copyWith({
    CameraFetchStatus? status,
    List<Camera>? data,
  }) {
    return CameraState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, data];
}
