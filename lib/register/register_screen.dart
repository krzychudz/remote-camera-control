import 'package:app/common/model/email.dart';
import 'package:app/common/snackbar/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../register/bloc/register_cubit.dart';
import '../../register/bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  void _onSubmissionFailure(RegisterState state, BuildContext context) {
    var arePasswordEqual = state.password.value == state.rePassword.value;
    context.showSnackbarMessage(
      message: arePasswordEqual
          ? tr('registration_faliure')
          : tr('password_not_the_same'),
      isError: !arePasswordEqual,
    );
  }

  void _onSubmissionSuccess(BuildContext context) {
    context.showSnackbarMessage(
      message: tr('account_created'),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("registration_title").tr(),
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            _onSubmissionFailure(state, context);
          } else if (state.status.isSubmissionSuccess) {
            _onSubmissionSuccess(context);
          }
        },
        child: const RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  Widget _buildUsernameFormField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          onChanged: (username) =>
              context.read<RegisterCubit>().onUsernameChanged(username),
          key: const Key('registerForm_usernameInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: tr('username'),
            errorText:
                state.username.invalid ? tr('user_name_empty_error') : null,
          ),
        );
      },
    );
  }

  Widget _buildEmailFormField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          onChanged: (email) =>
              context.read<RegisterCubit>().onEmailChanged(email),
          key: const Key('registerForm_emailInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: tr('email_label'),
            errorText: state.email.invalid ? _getEmailErrorField(state) : null,
          ),
        );
      },
    );
  }

  String _getEmailErrorField(RegisterState state) {
    if (state.email.error == EmailValidationError.empty) {
      return tr('email_empty_error');
    } else if (state.email.error == EmailValidationError.invalidFormat) {
      return tr('email_invalid_format_error');
    }
    return "";
  }

  Widget _buildPasswordFormField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          textInputAction: TextInputAction.next,
          onChanged: (password) =>
              context.read<RegisterCubit>().onPasswordChanged(password),
          key: const Key('registerForm_passwordInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: tr('password'),
            errorText:
                state.password.invalid ? tr('password_empty_error') : null,
          ),
        );
      },
    );
  }

  Widget _buildPasswordRetypeFormField() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.rePassword != current.rePassword,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          textInputAction: TextInputAction.done,
          onChanged: (rePassword) =>
              context.read<RegisterCubit>().onRePasswordChanged(rePassword),
          key: const Key('registerForm_passwordRetypeInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: tr('retype_password'),
            errorText:
                state.rePassword.invalid ? tr('field_empty_error') : null,
          ),
        );
      },
    );
  }

  void _onSubmitPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<RegisterCubit>().onSubmited();
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<RegisterCubit, RegisterState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Column(
            children: [
              if (state.status.isSubmissionInProgress)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CircularProgressIndicator(),
                ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  key: const Key("registerForm_submit_elevatedButton"),
                  onPressed: state.status.isValidated &&
                          !state.status.isSubmissionInProgress
                      ? () => _onSubmitPressed(context)
                      : null,
                  child: const Text(
                    "sign_up",
                  ).tr(),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "registration_explanation",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ).tr(),
            const SizedBox(
              height: 32,
            ),
            _buildEmailFormField(),
            const SizedBox(
              height: 16,
            ),
            _buildUsernameFormField(),
            const SizedBox(
              height: 16,
            ),
            _buildPasswordFormField(),
            const SizedBox(
              height: 16,
            ),
            _buildPasswordRetypeFormField(),
            const SizedBox(
              height: 32,
            ),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }
}
