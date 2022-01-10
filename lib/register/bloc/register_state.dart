import 'package:app/common/model/email.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../common/model/password.dart';
import '../../../../common/model/username.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.rePassword = const Password.pure()});

  final FormzStatus status;
  final Username username;
  final Email email;
  final Password password;
  final Password rePassword;

  RegisterState copyWith({
    FormzStatus? status,
    Username? username,
    Email? email,
    Password? password,
    Password? rePassword,
  }) {
    return RegisterState(
        status: status ?? this.status,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword);
  }

  @override
  List<Object> get props => [status, username, email, password, rePassword];
}
