import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String password;

  const User({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
  
  String toJsonString() {
    return jsonEncode(toJson());
  }
  
  factory User.fromJsonString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }
}

class UserService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'currentUser';

  static Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersKey) ?? [];

    return usersJson.map((jsonString) {
      try {
        return User.fromJsonString(jsonString);
      } catch (e) {
        return null;
      }
    }).whereType<User>().toList();
  }

  static Future<void> saveUser(User user) async {
    final users = await getUsers();

    // Проверяем, существует ли пользователь с таким email
    final existingIndex = users.indexWhere((u) => u.email == user.email);

    if (existingIndex >= 0) {
      users[existingIndex] = user;
    } else {
      users.add(user);
    }

    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((u) => u.toJsonString()).toList();
    await prefs.setStringList(_usersKey, usersJson);
  }

  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserEmail = prefs.getString(_currentUserKey);

    if (currentUserEmail == null) return null;

    final users = await getUsers();
    return users.where((user) => user.email == currentUserEmail).firstOrNull;
  }

  static Future<void> setCurrentUser(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user == null) {
      await prefs.remove(_currentUserKey);
    } else {
      await prefs.setString(_currentUserKey, user.email);
    }
  }

  static Future<bool> login(String email, String password) async {
    final users = await getUsers();
    final user = users.where((u) => u.email == email && u.password == password).firstOrNull;

    if (user != null) {
      await setCurrentUser(user);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    await setCurrentUser(null);
  }

  static Future<bool> isLoggedIn() async {
    final currentUser = await getCurrentUser();
    return currentUser != null;
  }
}

extension FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
