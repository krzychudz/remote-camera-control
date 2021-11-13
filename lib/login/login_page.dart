import 'package:app/login/login_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
