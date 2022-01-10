import 'package:app/common/model/email.dart';
import 'package:app/common/model/password.dart';
import 'package:app/common/model/username.dart';
import 'package:app/register/bloc/register_state.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const RegisterState());

  final UserRepository _userRepository;

  void onUsernameChanged(String newUsernameState) {
    final username = Username.dirty(newUsernameState);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [state.password, username, state.rePassword, state.email],
        ),
      ),
    );
  }

  void onEmailChanged(String newEmailState) {
    final email = Email.dirty(newEmailState);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [state.password, email, state.rePassword, state.username],
        ),
      ),
    );
  }

  void onPasswordChanged(String newPasswordState) {
    final password = Password.dirty(newPasswordState);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [password, state.rePassword, state.username, state.email],
        ),
      ),
    );
  }

  void onRePasswordChanged(String newRePasswordState) {
    final rePassword = Password.dirty(newRePasswordState);
    emit(
      state.copyWith(
        rePassword: rePassword,
        status: Formz.validate(
          [rePassword, state.password, state.username, state.email],
        ),
      ),
    );
  }

  void onSubmited() async {
    if (state.password.value != state.rePassword.value) {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
      return;
    }

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _userRepository.registerUser(
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (ex) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
