import 'package:app/camera_installation/camera_installation_page.dart';
import 'package:app/network_config/network_config_screen.dart';
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
      final data = Map<String, String>.from(args as Map<dynamic, dynamic>);
      cameraArgs = Camera.fromJson(data);

      destination = LivestreamPage(cameraData: cameraArgs);
      break;
    case "/camera_installation":
      destination = const CameraInstallationPage();
      break;
    case "/network_cofiguration":
      print("Here");
      destination = NetworkConfigScreen();
      break;
    default:
      destination = const LoginPage();
  }

  return MaterialPageRoute(builder: (context) => destination);
}
