import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question_model.dart';

class FeedbackViewModel extends ChangeNotifier {
  Map<String, List<QuestionModel>> questionsBySection = {};

  void loadFromJson(Map<String, dynamic> json) {
    questionsBySection = json.map((section, list) {
      return MapEntry(
        section,
        (list as List)
            .map(
              (e) => QuestionModel(
                titulo: e['titulo'],
                min: e['min'],
                max: e['max'],
                valor: e['valor'] ?? 0,
              ),
            )
            .toList(),
      );
    });

    notifyListeners();
  }

  void updateAnswer(String section, int index, int value) {
    questionsBySection[section]![index].valor = value;
    notifyListeners();
  }

  bool get allAnswered {
    return questionsBySection.values.every(
      (list) => list.every((q) => q.valor > 0),
    );
  }

  Future<void> sendFeedback(String username, String email) async {
    final answers = questionsBySection.entries.expand((entry) {
      return entry.value.map((q) {
        return {"section": entry.key, "question": q.titulo, "answer": q.valor};
      });
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
