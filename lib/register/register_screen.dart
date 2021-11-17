import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  Widget _buildUsernameFormField() {
    return const TextField(
        textInputAction: TextInputAction.next,
        key: Key('registerForm_usernameInput_textField'),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
        ));
  }

  Widget _buildPasswordFormField() {
    return const TextField(
        obscureText: true,
        textInputAction: TextInputAction.next,
        key: Key('registerForm_passwordInput_textField'),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ));
  }

  Widget _buildPasswordRetypeFormField() {
    return const TextField(
        obscureText: true,
        textInputAction: TextInputAction.done,
        key: Key('registerForm_passwordRetypeInput_textField'),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Retype password',
        ));
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
