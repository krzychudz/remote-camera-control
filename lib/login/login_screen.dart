import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
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
              ..showSnackBar(SnackBar(
                content: const Text('authentication_failure').tr(),
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
              labelText: tr('username'),
              errorText:
                  state.username.invalid ? tr('user_name_empty_error') : null),
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
              labelText: tr('password'),
              errorText:
                  state.password.invalid ? tr('password_empty_error') : null),
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
                  "login",
                ).tr(),
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
        text: tr('no_account'),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: tr('register_now'),
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
