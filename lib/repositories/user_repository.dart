import 'package:app/auth/user.dart';
import 'package:app/network/services/user/user_service_interface.dart';

class UserRepository {
  UserRepository(this.userServiceInterface);

  final UserServiceInterface userServiceInterface;

  User? _user;

  Future<User?> getUser() async {
    return User("tmp_email@gmail.com", "John", "Smith");
  }

  Future<bool> registerUser({email, password, username}) async {
    return Future.delayed(const Duration(seconds: 3), () => true);
  }

  void saveUser(User userData) => _user = userData;
}
