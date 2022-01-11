import 'dart:async';

import 'package:app/network/services/user/user_service_interface.dart';
import 'package:uuid/uuid.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    required this.userServiceInterface,
  });

  final UserServiceInterface userServiceInterface;

  final _authController = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO: Check if there is stored token
    yield AuthenticationStatus.authenticated;
    yield* _authController.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    var tokenResponse = await userServiceInterface.login({
      "email": email,
      "password": password,
      "device_name": const Uuid().v4()
    });

    _authController.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _authController.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _authController.close();
}
