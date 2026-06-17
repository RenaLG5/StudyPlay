import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/services/sound_service.dart';
import '/controller/achievement_controller.dart';
import '/services/notification_service.dart';

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

    difficulty = prefs.getString("difficulty_$_userKey") ?? "Fácil";
    notifications = prefs.getBool("notifications_$_userKey") ?? true;
    darkMode = prefs.getBool("darkMode_$_userKey") ?? false;

    sound = prefs.getBool("sound_$_userKey") ?? true;

    SoundService.setEnabled(sound);

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

    difficulty = "Fácil";
    notifications = true;
    darkMode = false;
    sound = true;

    _userKey = "";

    notifyListeners();
  }

  Future<void> saveUserData() async {
    if (_userKey.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username_$_userKey", username);
    await prefs.setString("age_$_userKey", age);
    await prefs.setString("country_$_userKey", country);

    await prefs.setString("difficulty_$_userKey", difficulty);
    await prefs.setBool("notifications_$_userKey", notifications);
    await prefs.setBool("darkMode_$_userKey", darkMode);
    await prefs.setBool("sound_$_userKey", sound);
  }

  Future<void> saveUsername(String value) async {
    if (_userKey.isEmpty) return;

    username = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username_$_userKey", value);

    notifyListeners();
  }

  Future<void> saveAge(String value) async {
    if (_userKey.isEmpty) return;

    age = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("age_$_userKey", value);

    notifyListeners();
  }

  Future<void> saveCountry(String value) async {
    if (_userKey.isEmpty) return;

    country = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("country_$_userKey", value);

    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode_$_userKey", value);

    notifyListeners();
  }

  Future<void> setSound(bool value) async {
    sound = value;

    SoundService.setEnabled(value);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("sound_$_userKey", value);

    notifyListeners();
  }

  Future<void> setNotifications(bool value) async {
    notifications = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifications_$_userKey", value);

    if (value) {
      await NotificationService.scheduleDaily();
    } else {
      await NotificationService.cancelAll();
    }

    notifyListeners();
  }
}
