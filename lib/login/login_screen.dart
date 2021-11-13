import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.red,
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
      )),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  Widget _buildLoginFormField() {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Login',
      ),
    );
  }

  Widget _buildPasswordFormField() {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        child: const Text(
          "Zaloguj",
        ),
        onPressed: () => {},
      ),
    );
  }

  RichText _buildRegisterSection() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: "Nie masz konta?\n",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: 'Zarejestruj się',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
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
            child: _buildRegisterSection(),
          ),
        ),
      ],
    );
  }
}
