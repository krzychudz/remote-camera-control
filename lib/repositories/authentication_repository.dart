import 'dart:async';

import 'package:app/cache/cache_keys.dart' as CacheKeys;
import 'package:app/network/services/user/user_service_interface.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    required this.userServiceInterface,
  });

  final UserServiceInterface userServiceInterface;

  final _authController = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    if (await _isUserLoggedIn()) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

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

    var storage = await Hive.openBox(CacheKeys.tokenBoxName);
    storage.put(CacheKeys.tokenKey, tokenResponse);

    _authController.add(AuthenticationStatus.authenticated);
  }

  Future<void> logOut() async {
    var storage = await Hive.openBox(CacheKeys.tokenBoxName);
    await storage.clear();

    _authController.add(AuthenticationStatus.unauthenticated);
  }

  Future<bool> _isUserLoggedIn() async {
    var storage = await Hive.openBox(CacheKeys.tokenBoxName);
    return storage.keys.isNotEmpty;
  }

  void dispose() => _authController.close();
}
