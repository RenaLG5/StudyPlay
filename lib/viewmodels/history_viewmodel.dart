import 'package:flutter/material.dart';
import '../models/game_result.dart';
import 'package:provider/provider.dart';

class HistoryViewModel extends ChangeNotifier {
  final List<GameResult> _results = [];

  List<GameResult> get results => _results;

  void addResult(GameResult result) {
    _results.insert(0, result); // lo más nuevo arriba
    notifyListeners();
  }
}
