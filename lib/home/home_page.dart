import 'package:app/repositories/camera_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CameraRepository>(
      create: (ctx) => CameraRepository(),
      child: HomeScreen(),
    );
  }
}
