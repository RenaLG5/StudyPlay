import 'package:flutter/material.dart';
import '../services/preferences_services.dart';

class SettingsViewModel extends ChangeNotifier {
  final PreferencesService _service = PreferencesService();

  String username = '';
  String difficulty = 'Fácil';
  bool notifications = true;

  String email = '';
  String age = '';
  String country = '';

  SettingsViewModel() {
    loadSettings();
  }

  bool darkMode = false;

  void setDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }

  bool sound = true;

  void setSound(bool value) {
    sound = value;
    notifyListeners();
  }

  void setNotifications(bool value) {
    notifications = value;
    notifyListeners();
  }

  Future<void> loadSettings() async {
    username = await _service.loadUsername();
    difficulty = await _service.loadDifficulty();
    notifications = await _service.loadNotifications();
    email = await _service.loadEmail();
    age = await _service.loadAge();
    country = await _service.loadCountry();
    darkMode = await _service.loadDarkMode();

    notifyListeners();
  }

  Future<void> saveUsername(String value) async {
    username = value;
    await _service.saveUsername(value);
    notifyListeners();
  }

  Future<void> saveDifficulty(String value) async {
    difficulty = value;
    await _service.saveDifficulty(value);
    notifyListeners();
  }

  Future<void> saveNotifications(bool value) async {
    notifications = value;
    await _service.saveNotifications(value);
    notifyListeners();
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setDifficulty(String value) {
    difficulty = value;
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

  Future<void> saveSettings() async {
    await _service.saveUsername(username);
    await _service.saveDifficulty(difficulty);
    await _service.saveNotifications(notifications);

    await _service.saveEmail(email);
    await _service.saveAge(age);
    await _service.saveCountry(country);

    await _service.saveDarkMode(darkMode);
  }
}
