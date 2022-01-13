import 'dart:async';
import 'dart:convert';

import 'package:app/cache/cache_keys.dart' as CacheKeys;
import 'package:app/network/services/user/user_service_interface.dart';
import 'package:app/notifications/notification_service.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({required this.userServiceInterface});

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
    final notificationService = NotificationsService.instance();
    final fcmToken = await notificationService.notificationToken;

    var tokenResponse = await userServiceInterface.login({
      "email": email,
      "password": password,
      "device_name": const Uuid().v4(),
      "fcm": fcmToken
    });

    Map<String, dynamic> jsonResponse = jsonDecode(tokenResponse.toString());

    var tokenBearer = jsonResponse["bearer"];
    var userData = jsonResponse["user"];

    var storage = await Hive.openBox(CacheKeys.tokenBoxName);
    storage.put(CacheKeys.tokenKey, tokenBearer);
    storage.close();

    await _saveCurrentUserData(userData);

    _authController.add(AuthenticationStatus.authenticated);
  }

  Future<void> _saveCurrentUserData(Map<String, dynamic> userData) async {
    var storage = await Hive.openBox(CacheKeys.currentUserBoxName);
    storage.put(CacheKeys.currentUserEmailKey, userData["email"]);
    storage.put(CacheKeys.currentUserNameKey, userData["name"]);
    storage.close();
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
