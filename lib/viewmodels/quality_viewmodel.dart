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

    final List<dynamic> data = jsonDecode(jsonString);

    questions = data.map((e) => QuestionModel.fromJson(e)).toList();

    notifyListeners();
  }

  void answerQuestion(int index, int value) {
    questions[index].answer = value;

    notifyListeners();
  }

  bool get allAnswered {
    return questions.every((q) => q.answer > 0);
  }
}
