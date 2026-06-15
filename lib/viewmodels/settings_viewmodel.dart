import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  String currentUser = "";

  String username = "";
  String difficulty = "Fácil";

  bool notifications = true;
  bool darkMode = false;
  bool sound = true;

  String email = "";
  String age = "";
  String country = "";

  SettingsViewModel() {
    loadCurrentUser();
  }

  //---------------------------
  // Usuario actual
  //---------------------------

  Future<void> setCurrentUser(String value) async {
    currentUser = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("currentUser", value);

    await loadUserData();

    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    currentUser = prefs.getString("currentUser") ?? "";

    await loadUserData();
  }

  //---------------------------
  // Cargar datos del usuario
  //---------------------------

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    if (currentUser.isEmpty) {
      username = "";
      email = "";
      age = "";
      country = "";

      difficulty = "Fácil";

      notifications = true;

      darkMode = false;

      sound = true;

      notifyListeners();

      return;
    }

    username = prefs.getString("username_$currentUser") ?? "";

    email = currentUser;

    age = prefs.getString("age_$currentUser") ?? "";

    country = prefs.getString("country_$currentUser") ?? "";

    difficulty = prefs.getString("difficulty") ?? "Fácil";

    notifications = prefs.getBool("notifications") ?? true;

    darkMode = prefs.getBool("darkMode") ?? false;

    sound = prefs.getBool("sound") ?? true;

    notifyListeners();
  }

  //---------------------------
  // SETTERS
  //---------------------------

  void setUsername(String value) {
    username = value;

    notifyListeners();
  }

  void setEmail(String value) {
    email = value;

    notifyListeners();
  }

  void setAge(String value) {
    age = value;

    notifyListeners();
  }

  void setCountry(String value) {
    country = value;

    notifyListeners();
  }

  void setDifficulty(String value) {
    difficulty = value;

    notifyListeners();
  }

  void setNotifications(bool value) {
    notifications = value;

    notifyListeners();
  }

  //---------------------------
  // Guardar individual
  //---------------------------

  Future<void> saveUsername(String value) async {
    if (currentUser.isEmpty) return;

    username = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username_$currentUser", value);

    notifyListeners();
  }

  Future<void> saveAge(String value) async {
    if (currentUser.isEmpty) return;

    age = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("age_$currentUser", value);

    notifyListeners();
  }

  Future<void> saveCountry(String value) async {
    if (currentUser.isEmpty) return;

    country = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("country_$currentUser", value);

    notifyListeners();
  }

  Future<void> saveDifficulty(String value) async {
    difficulty = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("difficulty", value);

    notifyListeners();
  }

  Future<void> saveNotifications(bool value) async {
    notifications = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("notifications", value);

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

  //---------------------------
  // Guardar todo
  //---------------------------

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (currentUser.isNotEmpty) {
      await prefs.setString("username_$currentUser", username);

      await prefs.setString("age_$currentUser", age);

      await prefs.setString("country_$currentUser", country);
    }

    await prefs.setString("difficulty", difficulty);

    await prefs.setBool("notifications", notifications);

    await prefs.setBool("darkMode", darkMode);

    await prefs.setBool("sound", sound);

    notifyListeners();
  }

  //---------------------------
  // Cerrar sesión
  //---------------------------

  Future<void> logout() async {
    currentUser = "";

    username = "";

    email = "";

    age = "";

    country = "";

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("currentUser");

    notifyListeners();
  }
}
