import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../common/model/password.dart';
import '../../../../common/model/username.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.rePassword = const Password.pure()});

  final FormzStatus status;
  final Username username;
  final Password password;
  final Password rePassword;

  RegisterState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Password? rePassword,
  }) {
    return RegisterState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword);
  }

  @override
  List<Object> get props => [status, username, password, rePassword];
}
