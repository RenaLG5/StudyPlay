import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/feedback_question.dart';

class FeedbackViewModel extends ChangeNotifier {
  final List<FeedbackQuestion> questions = [
    FeedbackQuestion(text: 'La aplicación es fácil de usar'),
    FeedbackQuestion(text: 'La navegación es intuitiva'),
    FeedbackQuestion(text: 'El diseño es atractivo'),
    FeedbackQuestion(text: 'Las funciones cumplen mis expectativas'),
    FeedbackQuestion(text: 'Recomendaría StudyPlay a otras personas'),
  ];

  void updateAnswer(int index, int value) {
    questions[index].answer = value;
    notifyListeners();
  }

  bool get allAnswered {
    return questions.every((q) => q.answer > 0);
  }

  Future<void> sendFeedback() async {
    String body = '';

    for (final question in questions) {
      body += '${question.text}: ${question.answer}/5\n';
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'profesor@utalca.cl', // cambiar por correo real
      queryParameters: {'subject': 'Valoración StudyPlay', 'body': body},
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}
