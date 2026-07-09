import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/quiz_model.dart';

class FirestoreQuestionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Question>> getQuestions({
    required int course,
    required String subject,
    required int level,
    int limit = 5,
  }) async {
    final cacheKey = "questions_course_${course}_${subject}_level_$level";

    try {
      final snapshot = await _db
          .collection("questions")
          .where("course", isEqualTo: course)
          .where("subject", isEqualTo: subject)
          .where("level", isEqualTo: level)
          .get();

      List<Question> questions = snapshot.docs.map((doc) {
        return Question.fromFirestore(doc.data());
      }).toList();

      if (questions.isNotEmpty) {
        questions.shuffle(Random());

        final selected = questions.take(limit).toList();

        await _saveCache(cacheKey, selected);

        return selected;
      }

      return await _loadCache(cacheKey);
    } catch (e) {
      return await _loadCache(cacheKey);
    }
  }

  Future<List<Question>> getReplayQuestions({
    required int course,
    required String subject,
    int limit = 5,
  }) async {
    final cacheKey = "replay_questions_course_${course}_$subject";

    try {
      final snapshot = await _db
          .collection("questions")
          .where("course", isEqualTo: course)
          .where("subject", isEqualTo: subject)
          .get();

      List<Question> questions = snapshot.docs.map((doc) {
        return Question.fromFirestore(doc.data());
      }).toList();

      if (questions.isNotEmpty) {
        questions.shuffle(Random());

        final selected = questions.take(limit).toList();

        await _saveCache(cacheKey, selected);

        return selected;
      }

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
