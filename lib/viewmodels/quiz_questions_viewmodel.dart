import 'package:flutter/material.dart';
import '/models/quiz_model.dart';
import '/services/firestore_question_service.dart';

class QuizQuestionsViewModel extends ChangeNotifier {
  final FirestoreQuestionService _service = FirestoreQuestionService();

  List<Question> questions = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadQuestions({
    required String subject,
    required int level,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      questions = await _service.getQuestions(subject: subject, level: level);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Error al cargar preguntas desde Firebase";
      notifyListeners();
    }
  }
}
