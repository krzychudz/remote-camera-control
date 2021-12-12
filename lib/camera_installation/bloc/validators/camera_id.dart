import 'package:formz/formz.dart';

enum CameraIdValidationError { empty }

class CameraId extends FormzInput<String, CameraIdValidationError> {
  const CameraId.pure() : super.pure('');
  const CameraId.dirty([String value = '']) : super.dirty(value);

  @override
  CameraIdValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CameraIdValidationError.empty;
  }
}
