import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/question_model.dart';

class QualityViewModel extends ChangeNotifier {
  List<QuestionModel> questions = [];

  Future<void> loadQuestions() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/quality_questions.json',
    );

    final Map<String, dynamic> data = jsonDecode(jsonString);

    questions = [];

    for (final q in data["usabilidad"]) {
      questions.add(QuestionModel.fromJson(q));
    }

    for (final q in data["contenido"]) {
      questions.add(QuestionModel.fromJson(q));
    }

    for (final q in data["compartir"]) {
      questions.add(QuestionModel.fromJson(q));
    }

    notifyListeners();
  }

  void answerQuestion(int index, int value) {
    questions[index].valor = value;

    notifyListeners();
  }

  bool get allAnswered {
    return questions.every((q) => q.valor > 0);
  }
}
