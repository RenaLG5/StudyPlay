import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/quiz_model.dart';

class FirestoreQuestionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Question>> getQuestions({
    required String subject,
    required int level,
  }) async {
    final snapshot = await _db
        .collection("questions")
        .where("subject", isEqualTo: subject)
        .where("level", isEqualTo: level)
        .get();

    return snapshot.docs.map((doc) {
      return Question.fromFirestore(doc.data());
    }).toList();
  }
}
