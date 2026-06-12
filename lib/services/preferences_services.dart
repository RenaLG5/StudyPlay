import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _usernameKey = 'username';
  static const String _difficultyKey = 'difficulty';
  static const String _notificationsKey = 'notifications';

  static const String _emailKey = 'email';
  static const String _ageKey = 'age';
  static const String _countryKey = 'country';

  static const String _darkModeKey = 'darkMode';

  // Usuario
  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  Future<String> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey) ?? '';
  }

  // Dificultad
  Future<void> saveDifficulty(String difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_difficultyKey, difficulty);
  }

  Future<String> loadDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_difficultyKey) ?? 'Fácil';
  }

  // correo, edad, país
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  Future<String> loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? '';
  }

  Future<void> saveAge(String age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ageKey, age);
  }

  Future<String> loadAge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_ageKey) ?? '';
  }

  Future<void> saveCountry(String country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_countryKey, country);
  }

  Future<String> loadCountry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_countryKey) ?? '';
  }

  // Notificaciones
  Future<void> saveNotifications(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }

  Future<bool> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }

  Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }

  // Cargar el estado del modo oscuro
  Future<bool> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey) ?? false;
  }
}
