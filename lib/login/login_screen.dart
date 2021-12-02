import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../login/bloc/login_bloc.dart';
import '../../login/bloc/login_state.dart';
import '../../login/bloc/login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) => {
        if (state.status.isSubmissionFailure)
          {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text("Authentication Failure"),
              ))
          }
      },
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/SmartCamLogoAlpha.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  void onRegisterClicked(BuildContext context) {
    Navigator.of(context).pushNamed(
      "/register",
    );
  }

  Widget _buildLoginFormField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username),
              ),
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Username',
              errorText:
                  state.username.invalid ? 'Username cannot be empty' : null),
        );
      },
    );
  }

  Widget _buildPasswordFormField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.done,
          obscureText: true,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password),
              ),
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Password',
              errorText:
                  state.password.invalid ? 'Password cannot be empty' : null),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
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
                key: const Key("loginForm_submit_elevatedButton"),
                child: const Text(
                  "Login",
                ),
                onPressed: state.status.isValidated &&
                        !state.status.isSubmissionInProgress
                    ? () => _onSubmitPressed(context)
                    : null,
              ),
            )
          ],
        );
      },
    );
  }

  RichText _buildRegisterSection(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Nie masz konta?\n",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: 'Zarejestruj się',
            recognizer: TapGestureRecognizer()
              ..onTap = () => onRegisterClicked(context),
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmitPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(
          const LoginSubmitted(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLoginFormField(),
        const SizedBox(
          height: 16,
        ),
        _buildPasswordFormField(),
        const SizedBox(
          height: 32,
        ),
        _buildSubmitButton(),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: _buildRegisterSection(context),
          ),
        ),
      ],
    );
  }
}
