import 'package:app/auth/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    //TODO get user from backend
  }

  Future<bool> registerUser({username, password}) async {
    return Future.delayed(const Duration(seconds: 3), () => true);
  }

  void saveUser(User userData) => _user = userData;
}
