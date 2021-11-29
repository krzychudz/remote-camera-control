import 'package:app/auth/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    return User("tmp_email@gmail.com", "John", "Smith");
  }

  Future<bool> registerUser({username, password}) async {
    return Future.delayed(const Duration(seconds: 3), () => true);
  }

  void saveUser(User userData) => _user = userData;
}
