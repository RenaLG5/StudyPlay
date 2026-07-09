import 'package:flutter/material.dart';

import '/models/quiz_model.dart';
import '/services/firestore_question_service.dart';

class QuizQuestionsViewModel extends ChangeNotifier {
  final FirestoreQuestionService _service = FirestoreQuestionService();

  List<Question> questions = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadQuestions({
    required int course,
    required String subject,
    required int level,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      questions = await _service.getQuestions(
        course: course,
        subject: subject,
        level: level,
      );

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Error al cargar preguntas";
      notifyListeners();
    }
  }

  Future<void> loadReplayQuestions({
    required int course,
    required String subject,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      questions = await _service.getReplayQuestions(
        course: course,
        subject: subject,
      );

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Error al cargar preguntas aleatorias";
      notifyListeners();
    }
  }
}
