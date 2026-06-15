import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsViewModel extends ChangeNotifier {
  String username = "";
  String difficulty = "Fácil";

  bool notifications = true;
  bool darkMode = false;
  bool sound = true;

  String age = "";
  String country = "";

  String _userKey = "";

  String profileImagePath = "";

  String get displayName {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return "Invitado";

    if (username.isNotEmpty) return username;

    return user.email!.split("@")[0];
  }

  Future<void> setCurrentUser(String email) async {
    _userKey = email;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("currentUser", email);

    await loadUserData();
    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    _userKey = prefs.getString("currentUser") ?? "";

    await loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    if (_userKey.isEmpty) {
      username = "";
      age = "";
      country = "";
      difficulty = "Fácil";
      notifications = true;
      darkMode = false;
      sound = true;
      notifyListeners();
      return;
    }
    profileImagePath = prefs.getString("profileImage_$_userKey") ?? "";
    username = prefs.getString("username_$_userKey") ?? "";
    age = prefs.getString("age_$_userKey") ?? "";
    country = prefs.getString("country_$_userKey") ?? "";

    difficulty = prefs.getString("difficulty") ?? "Fácil";
    notifications = prefs.getBool("notifications") ?? true;
    darkMode = prefs.getBool("darkMode") ?? false;
    sound = prefs.getBool("sound") ?? true;

    notifyListeners();
  }

  Future<void> setProfileImage(String path) async {
    profileImagePath = path;

    final prefs = await SharedPreferences.getInstance();

    if (_userKey.isNotEmpty) {
      await prefs.setString("profileImage_$_userKey", path);
    }

    notifyListeners();
  }

  Future<void> clearUserData() async {
    username = "";
    age = "";
    country = "";
    profileImagePath = "";
    _userKey = "";

    notifyListeners();
  }

  Future<void> saveUserData() async {
    if (_userKey.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username_$_userKey", username);
    await prefs.setString("age_$_userKey", age);
    await prefs.setString("country_$_userKey", country);

    await prefs.setString("difficulty", difficulty);
    await prefs.setBool("notifications", notifications);
    await prefs.setBool("darkMode", darkMode);
    await prefs.setBool("sound", sound);
  }

  Future<void> saveUsername(String value) async {
    if (_userKey.isEmpty) return;

    username = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username_$_userKey", value);

    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", value);

    notifyListeners();
  }

  Future<void> setSound(bool value) async {
    sound = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("sound", value);

    notifyListeners();
  }

  Future<void> saveNotifications(bool value) async {
    notifications = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifications", value);

    notifyListeners();
  }
}
