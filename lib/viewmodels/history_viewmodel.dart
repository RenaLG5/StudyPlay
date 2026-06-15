import 'package:flutter/material.dart';
import '../models/game_result.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryViewModel extends ChangeNotifier {
  final List<GameResult> _results = [];

  List<GameResult> get results => _results;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("history");

    if (data != null) {
      final List decoded = jsonDecode(data);

      _results.clear();

      _results.addAll(decoded.map((e) => GameResult.fromJson(e)).toList());
    }

    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();

    final data = _results.map((e) => e.toJson()).toList();

    await prefs.setString("history", jsonEncode(data));
  }

  Future<void> addResult(GameResult result) async {
    _results.insert(0, result);

    await save();

    notifyListeners();
  }
}
