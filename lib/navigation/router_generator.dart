import 'package:flutter/material.dart';

import '../../common/model/camera/camera.dart';
import '../../home/home_page.dart';
import '../../livestream/livestream_page.dart';
import '../../login/login_page.dart';
import '../../login/login_screen.dart';
import '../../register/register_page.dart';
import '../../splash/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  Widget destination;

  switch (settings.name) {
    case "/":
      destination = const SplashScreen();
      break;
    case "/login":
      destination = const LoginPage();
      break;
    case "/register":
      destination = const RegisterPage();
      break;
    case "/home":
      destination = const HomePage();
      break;
    case "/livestream":
      Camera? cameraArgs;
      if (args is Map<String, String>) {
        cameraArgs = Camera.fromJson(args);
      }

      destination = LivestreamPage(cameraData: cameraArgs);
      break;
    default:
      destination = const LoginScreen();
  }

  return MaterialPageRoute(builder: (context) => destination);
}
