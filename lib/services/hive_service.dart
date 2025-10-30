import 'package:hive/hive.dart';
import 'package:tapak_jejak/models/user.dart';

class HiveService {
  static const String userBoxName = 'userBox';

  Future<void> initHive() async {
    await Hive.openBox(userBoxName);
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
}
