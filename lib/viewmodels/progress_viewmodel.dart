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

    mathCompleted: false,
    languageCompleted: false,
    scienceCompleted: false,
    historyCompleted: false,
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
        mathCompleted: false,
        languageCompleted: false,
        scienceCompleted: false,
        historyCompleted: false,
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

  Future<void> levelUp(String subject, bool passed) async {
    switch (subject) {
      case "Matemáticas":
        if (passed) {
          if (progress.mathLevel < 5) {
            progress.mathLevel++;
          }

          if (progress.mathLevel == 5 && passed) {
            progress.mathCompleted = true;
          }
        }
        break;

      case "Lenguaje":
        if (passed) {
          if (progress.languageLevel < 5) {
            progress.languageLevel++;
          }

          if (progress.languageLevel == 5 && passed) {
            progress.languageCompleted = true;
          }
        }
        break;

      case "Ciencias":
        if (passed) {
          if (progress.scienceLevel < 5) {
            progress.scienceLevel++;
          }

          if (progress.scienceLevel == 5 && passed) {
            progress.scienceCompleted = true;
          }
        }
        break;

      case "Historia":
        if (passed) {
          if (progress.historyLevel < 5) {
            progress.historyLevel++;
          }

          if (progress.historyLevel == 5 && passed) {
            progress.historyCompleted = true;
          }
        }
        break;
    }

    await save();
    notifyListeners();
  }
}
