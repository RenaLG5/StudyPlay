import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  String _username = '';

  String _difficulty = 'Fácil';

  String get username => _username;

  String get difficulty => _difficulty;

  int get gridSize => _difficulty == 'Fácil'
      ? 8
      : _difficulty == 'Medio'
      ? 10
      : 12;

  SettingsViewModel() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    _username = await StorageService.getUsername();

    _difficulty = await StorageService.getDifficulty();

    notifyListeners();
  }

  void setUsername(String value) {
    _username = value;

    notifyListeners();
  }

  void setDifficulty(String value) {
    _difficulty = value;

    notifyListeners();
  }

  Future<void> saveSettings() async {
    await StorageService.saveUsername(_username);

    await StorageService.saveDifficulty(_difficulty);
  }
}
