import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final PreferencesService _service = PreferencesService();

  String username = '';
  String difficulty = 'Fácil';
  bool notifications = true;

  Future<void> loadSettings() async {
    username = await _service.loadUsername();
    difficulty = await _service.loadDifficulty();
    notifications = await _service.loadNotifications();

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

  Future<void> saveSettings() async {
    await _service.saveUsername(username);
    await _service.saveDifficulty(difficulty);
    await _service.saveNotifications(notifications);
  }
}
