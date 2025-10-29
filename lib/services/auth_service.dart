import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart';

class AuthService {
  static const String _userBoxName = 'users';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _currentUserKey = 'currentUser';

  late Box<User> _userBox;
  late SharedPreferences _prefs;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    _userBox = await Hive.openBox<User>(_userBoxName);
    _prefs = await SharedPreferences.getInstance();
  }

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> register(String username, String password) async {
    if (username.isEmpty || password.isEmpty) return false;

    // Check if user already exists
    var existingUser = _userBox.values.firstWhere(
      (user) => user.username == username,
      orElse: () => User(username: '', passwordHash: ''),
    );

    if (existingUser.username.isNotEmpty) return false; // User exists

    String hashedPassword = _hashPassword(password);
    User newUser = User(username: username, passwordHash: hashedPassword);
    await _userBox.add(newUser);
    return true;
  }

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) return false;

    String hashedPassword = _hashPassword(password);
    var user = _userBox.values.firstWhere(
      (user) =>
          user.username == username && user.passwordHash == hashedPassword,
      orElse: () => User(username: '', passwordHash: ''),
    );

    if (user.username.isNotEmpty) {
      await _prefs.setBool(_isLoggedInKey, true);
      await _prefs.setString(_currentUserKey, username);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _prefs.setBool(_isLoggedInKey, false);
    await _prefs.remove(_currentUserKey);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  String? getCurrentUser() {
    return _prefs.getString(_currentUserKey);
  }

  Future<void> close() async {
    await _userBox.close();
  }
}
