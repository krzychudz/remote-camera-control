import 'package:formz/formz.dart';

enum CameraRoomValidationError { empty }

class CameraRoom extends FormzInput<String, CameraRoomValidationError> {
  const CameraRoom.pure() : super.pure('');
  const CameraRoom.dirty([String value = '']) : super.dirty(value);

  @override
  CameraRoomValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CameraRoomValidationError.empty;
  }
}
