import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/quiz_model.dart';

class FirestoreQuestionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Question>> getQuestions({
    required String subject,
    required int level,
  }) async {
    final cacheKey = "questions_${subject}_$level";

    try {
      final snapshot = await _db
          .collection("questions")
          .where("subject", isEqualTo: subject)
          .where("level", isEqualTo: level)
          .get();

      final questions = snapshot.docs.map((doc) {
        return Question.fromFirestore(doc.data());
      }).toList();

      if (questions.isNotEmpty) {
        await _saveCache(cacheKey, questions);
        return questions;
      }

      // Si Firestore respondió pero no encontró preguntas,
      // intenta usar la caché.
      return await _loadCache(cacheKey);
    } catch (e) {
      return await _loadCache(cacheKey);
    }
  }

  Future<void> _saveCache(String key, List<Question> questions) async {
    final prefs = await SharedPreferences.getInstance();

    final data = questions.map((q) => q.toJson()).toList();

    await prefs.setString(key, jsonEncode(data));
  }

  Future<List<Question>> _loadCache(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final cachedData = prefs.getString(key);

    if (cachedData == null) return [];

    final List<dynamic> decoded = jsonDecode(cachedData);

    return decoded.map((item) {
      return Question.fromJson(Map<String, dynamic>.from(item));
    }).toList();
  }
}
