import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final answers = questions.map((q) {
      return {'question': q.text, 'answer': q.answer};
    }).toList();

    await FirebaseFirestore.instance.collection('feedback_surveys').add({
      'answers': answers,
      'createdAt': FieldValue.serverTimestamp(),
    });

    String body = '';

    for (final q in questions) {
      body += '${q.text}: ${q.answer}/5\n';
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'rleon23@alumnos.utalca.cl',
      queryParameters: {'subject': 'Valoración StudyPlay', 'body': body},
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("No se encontró una app de correo");
    }

    debugPrint("Feedback enviado a Firebase + mailto abierto");
  }
}
