import 'package:hive/hive.dart';
import 'package:tapak_jejak/models/user.dart';

class HiveService {
  static const String userBoxName = 'userBox';
  static const String sessionBoxName = 'sessionBox';

  Future<void> initHive() async {
    await Hive.openBox(userBoxName);
    await Hive.openBox(sessionBoxName);
  }

  Future<void> saveUserData(String username, User user) async {
    final box = await Hive.openBox(userBoxName);
    await box.put('${username}_user', user);
  }

  Future<User?> getUserData(String username) async {
    final box = await Hive.openBox(userBoxName);
    return box.get('${username}_user');
  }

  Future<void> saveProfileImage(String username, String imagePath) async {
    final box = await Hive.openBox(userBoxName);
    await box.put('${username}_profileImage', imagePath);
  }

  Future<String?> getProfileImage(String username) async {
    final box = await Hive.openBox(userBoxName);
    return box.get('${username}_profileImage');
  }

  Future<void> clearUserData(String username) async {
    final box = await Hive.openBox(userBoxName);
    await box.delete('${username}_user');
    await box.delete('${username}_profileImage');
  }

  // Session management
  Future<void> saveLoggedInUser(String username) async {
    final box = await Hive.openBox(sessionBoxName);
    await box.put('loggedInUser', username);
  }

  Future<String?> getLoggedInUser() async {
    final box = await Hive.openBox(sessionBoxName);
    return box.get('loggedInUser');
  }

  Future<void> logout() async {
    final box = await Hive.openBox(sessionBoxName);
    await box.delete('loggedInUser');
  }
}
