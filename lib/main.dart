import 'package:app/injection/injection.dart';
import 'package:app/network/services/camera/camera_service_interface.dart';
import 'package:app/network/services/user/user_service_interface.dart';
import 'package:app/notifications/notification_service.dart';
import 'package:app/repositories/camera_repository.dart';
import 'package:app/repositories/network_config/network_config_repository.dart';
import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../auth/bloc/authentication_bloc.dart';
import '../../auth/bloc/authentication_state.dart';
import '../../repositories/authentication_repository.dart';
import '../../repositories/user_repository.dart';

import '../../navigation/router_generator.dart' as router;
import 'cache/hive_init.dart';

Future<void> _initFirebaeNotification() async {
  final notificationService = NotificationsService.instance();
  await notificationService.initialize();
  final token = await notificationService.notificationToken;
  print(token);
}

void main() async {
  await initHive();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configurationInjection(Environment.dev);
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [Locale('en')],
    fallbackLocale: Locale('en'),
    child: MyApp(
      authenticationRepository: AuthenticationRepository(
        userServiceInterface: getIt<UserServiceInterface>(),
      ),
      userRepository: UserRepository(
        getIt<UserServiceInterface>(),
      ),
      cameraRepository: CameraRepository(
        getIt<CameraServiceInterface>(),
      ),
      networkConfigRepository: NetworkConfigRepository(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.cameraRepository,
    required this.networkConfigRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final CameraRepository cameraRepository;
  final NetworkConfigRepository networkConfigRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: userRepository),
        RepositoryProvider.value(value: cameraRepository),
        RepositoryProvider.value(value: networkConfigRepository)
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
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initializePushNotification();
    }
  }

  void _initializePushNotification() async {
    await _initFirebaeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCam',
      navigatorKey: _navKey,
      theme: getThemeData(context),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator?.pushNamedAndRemoveUntil(
                  "/home",
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
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
