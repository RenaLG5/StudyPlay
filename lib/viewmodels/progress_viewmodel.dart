import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/progress_model.dart';

class ProgressViewModel extends ChangeNotifier {
  ProgressModel progress = ProgressModel(
    mathLevel: 1,
    languageLevel: 1,
    scienceLevel: 1,
    historyLevel: 1,
  );

  String _email = "";

  Future<void> load(String email) async {
    final prefs = await SharedPreferences.getInstance();

    _email = email;

    final data = prefs.getString("progress_$email");

    if (data != null) {
      progress = ProgressModel.fromJson(jsonDecode(data));
    } else {
      progress = ProgressModel(
        mathLevel: 1,
        languageLevel: 1,
        scienceLevel: 1,
        historyLevel: 1,
      );
    }

    notifyListeners();
  }

  Future<void> save() async {
    if (_email.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("progress_$_email", jsonEncode(progress.toJson()));
  }

  int getLevel(String subject) {
    switch (subject) {
      case "Matemáticas":
        return progress.mathLevel;

      case "Lenguaje":
        return progress.languageLevel;

      case "Ciencias":
        return progress.scienceLevel;

      case "Historia":
        return progress.historyLevel;

      default:
        return 1;
    }
  }

  Future<void> levelUp(String subject) async {
    switch (subject) {
      case "Matemáticas":
        if (progress.mathLevel < 5) {
          progress.mathLevel++;
        }

        break;

      case "Lenguaje":
        if (progress.languageLevel < 5) {
          progress.languageLevel++;
        }

        break;

      case "Ciencias":
        if (progress.scienceLevel < 5) {
          progress.scienceLevel++;
        }

        break;

      case "Historia":
        if (progress.historyLevel < 5) {
          progress.historyLevel++;
        }

        break;
    }

    await save();

    notifyListeners();
  }
}
