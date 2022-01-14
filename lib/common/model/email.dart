import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalidFormat }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return EmailValidationError.empty;
    } else if (value != null && !_isEmailValid(value)) {
      return EmailValidationError.invalidFormat;
    }
    return null;
  }

  bool _isEmailValid(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
