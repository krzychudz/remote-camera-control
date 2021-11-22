import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:app/register/bloc/register_cubit.dart';
import 'package:app/register/bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  void _showSnackbarMessage(
      {required BuildContext context, required String message, bool? isError}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: isError == true
              ? Theme.of(context).errorColor
              : Theme.of(context).snackBarTheme.backgroundColor,
          content: Text(message),
        ),
      );
  }

  void _onSubmissionFailure(RegisterState state, BuildContext context) {
    var arePasswordEqual = state.password.value == state.rePassword.value;
    _showSnackbarMessage(
      context: context,
      message: arePasswordEqual
          ? "Registration Failure"
          : "Passwords must be the same",
      isError: !arePasswordEqual,
    );
  }

  void _onSubmissionSuccess(BuildContext context) {
    _showSnackbarMessage(
      context: context,
      message: "Your account has been created",
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
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
            labelText: 'Username',
            errorText:
                state.username.invalid ? 'Username cannot be empty' : null,
          ),
        );
      },
    );
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
            labelText: 'Password',
            errorText:
                state.password.invalid ? 'Password cannot be empty' : null,
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
            labelText: 'Retype password',
            errorText:
                state.rePassword.invalid ? 'This field cannot be empty' : null,
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
                    "Sign up",
                  ),
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
              "Fill the from to create an account!",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 32,
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
