import 'package:app/auth/user.dart';
import 'package:app/extensions/response_extenstion.dart';
import 'package:app/network/services/user/user_service_interface.dart';

class UserRepository {
  UserRepository(this.userServiceInterface);

  final UserServiceInterface userServiceInterface;

  User? _user;

  Future<User?> getUser() async {
    return User("tmp_email@gmail.com", "John", "Smith");
  }

  Future<void> registerUser({email, password, username}) async {
    var response = await userServiceInterface
        .registerUser({"name": username, "email": email, "password": password});

    if (!response.isSuccessful()) {
      throw Exception(response.data?.statusMessage);
    }
  }

  void saveUser(User userData) => _user = userData;
}
