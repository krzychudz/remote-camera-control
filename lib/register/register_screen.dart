import 'package:app/register/bloc/register_cubit.dart';
import 'package:app/register/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
      buildWhen: (previous, current) => previous.password != current.password,
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

  Widget _buildSubmitButton() {
    return const SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        key: Key("registerForm_submit_elevatedButton"),
        onPressed: null,
        child: Text(
          "Sign up",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: SizedBox(
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
      ),
    );
  }
}
