import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _authController = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO: Check if there is stored token
    yield AuthenticationStatus.unauthenticated;
    yield* _authController.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    //TODO: Auth user on backend
    await Future.delayed(
      const Duration(seconds: 3),
      () => _authController.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _authController.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _authController.close();
}
