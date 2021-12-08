import 'package:app/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../auth/bloc/authentication_bloc.dart';
import '../../auth/bloc/authentication_state.dart';
import '../../repositories/authentication_repository.dart';
import '../../repositories/user_repository.dart';

import '../../navigation/router_generator.dart' as router;

void main() {
  configurationInjection(Environment.dev);
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => authenticationRepository),
        RepositoryProvider<UserRepository>(create: (context) => userRepository)
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCam',
      navigatorKey: _navKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                print("AUTH!");
                _navigator?.pushNamedAndRemoveUntil(
                  "/home",
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                print("UNAUTH!");
                _navigator?.pushNamedAndRemoveUntil(
                  "/login",
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      initialRoute: "/",
      onGenerateRoute: router.generateRoute,
    );
  }
}
