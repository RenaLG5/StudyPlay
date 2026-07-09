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

  Future<void> load(String email, {int course = 1}) async {
    final prefs = await SharedPreferences.getInstance();

    _email = "${email}_course_$course";

    final data = prefs.getString("progress_$_email");

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

  Future<void> registerQuizResult(String subject, bool passed) async {
    switch (subject) {
      case "Matemáticas":
        if (passed) {
          if (progress.mathLevel == 5) {
            progress.mathCompleted = true;
          } else {
            progress.mathLevel++;
          }
        }
        break;

      case "Lenguaje":
        if (passed) {
          if (progress.languageLevel == 5) {
            progress.languageCompleted = true;
          } else {
            progress.languageLevel++;
          }
        }
        break;

      case "Ciencias":
        if (passed) {
          if (progress.scienceLevel == 5) {
            progress.scienceCompleted = true;
          } else {
            progress.scienceLevel++;
          }
        }
        break;

      case "Historia":
        if (passed) {
          if (progress.historyLevel == 5) {
            progress.historyCompleted = true;
          } else {
            progress.historyLevel++;
          }
        }
        break;
    }

    await save();
    notifyListeners();
  }
}
