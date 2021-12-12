import 'package:formz/formz.dart';

enum CameraNameValidationError { empty }

class CameraName extends FormzInput<String, CameraNameValidationError> {
  const CameraName.pure() : super.pure('');
  const CameraName.dirty([String value = '']) : super.dirty(value);

  @override
  CameraNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CameraNameValidationError.empty;
  }
}
