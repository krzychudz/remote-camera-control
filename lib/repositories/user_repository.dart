import 'package:app/auth/user.dart';
import 'package:app/extensions/response_extenstion.dart';
import 'package:app/network/services/user/user_service_interface.dart';
import 'package:app/cache/cache_keys.dart' as CacheKeys;
import 'package:hive/hive.dart';

class UserRepository {
  UserRepository(this.userServiceInterface);

  final UserServiceInterface userServiceInterface;

  Future<User?> getUser() async {
    var storage = await Hive.openBox(CacheKeys.currentUserBoxName);
    String? userEmail = storage.get(CacheKeys.currentUserEmailKey);
    String? userName = storage.get(CacheKeys.currentUserNameKey);
    storage.close();

    if (userEmail == null && userName == null) return null;

    return User(userEmail ?? "", userName ?? "");
  }

  Future<void> registerUser({email, password, username}) async {
    var response = await userServiceInterface
        .registerUser({"name": username, "email": email, "password": password});

    if (!response.isSuccessful()) {
      throw Exception(response.statusMessage);
    }
  }
}
