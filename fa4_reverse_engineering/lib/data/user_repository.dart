import 'package:fa4_reverse_engineering/models/user.dart';

class UserRepository {
  static final List<User> _users = [];
  static User? currentUser;

  static bool usernameTaken(String username) {
    return _users
        .any((u) => u.username.toLowerCase() == username.toLowerCase());
  }

  static void register(User user) {
    _users.add(user);
  }

  static User? login(String username, String password) {
    for (final user in _users) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  static void logout() {
    currentUser = null;
  }
}
