import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question_model.dart';

class FeedbackViewModel extends ChangeNotifier {
  final List<QuestionModel> questions = [
    QuestionModel(titulo: 'La aplicación es fácil de usar', min: '', max: ''),
    QuestionModel(titulo: 'La navegación es intuitiva', min: '', max: ''),
    QuestionModel(titulo: 'El diseño es atractivo', min: '', max: ''),
    QuestionModel(
      titulo: 'Las funciones cumplen mis expectativas',
      min: '',
      max: '',
    ),
    QuestionModel(
      titulo: 'Recomendaría StudyPlay a otras personas',
      min: '',
      max: '',
    ),
  ];

  void updateAnswer(int index, int value) {
    questions[index].valor = value;
    notifyListeners();
  }

  bool get allAnswered {
    return questions.every((q) => q.valor > 0);
  }

  Future<void> sendFeedback(String username, String email) async {
    final answers = questions.map((q) {
      return {"question": q.titulo, "answer": q.valor};
    }).toList();

    await FirebaseFirestore.instance
        .collection("feedback_surveys")
        .doc(email)
        .set({
          "name": username,
          "email": email,
          "answers": answers,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }
}
