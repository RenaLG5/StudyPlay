import 'package:flutter/material.dart';
import '../models/game_result.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryViewModel extends ChangeNotifier {
  final List<GameResult> _results = [];

  List<GameResult> get results => _results;

  String? _email;

  Future<void> load(String email) async {
    _email = email;

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("history_$email");

    _results.clear();

    if (data != null) {
      final List decoded = jsonDecode(data);

      _results.addAll(decoded.map((e) => GameResult.fromJson(e)));
    }

    notifyListeners();
  }

  Future<void> save() async {
    if (_email == null) return;

    final prefs = await SharedPreferences.getInstance();

    final jsonList = _results.map((e) => e.toJson()).toList();

    await prefs.setString("history_$_email", jsonEncode(jsonList));
  }

  void addResult(GameResult result) {
    _results.insert(0, result);

    save();

    notifyListeners();
  }
}
