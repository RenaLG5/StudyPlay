import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
  }

  static Future<void> saveDifficulty(String difficulty) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('difficulty', difficulty);
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('username') ?? '';
  }

  static Future<String> getDifficulty() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('difficulty') ?? 'Fácil';
  }
}
