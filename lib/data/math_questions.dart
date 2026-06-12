import '/models/quiz_model.dart';

class MathQuestions {
  static List<Question> list = [
    Question(text: "3 + 3 =", options: ["5", "6", "7", "8"], correctIndex: 1),
    Question(text: "10 - 4 =", options: ["5", "6", "7", "4"], correctIndex: 1),
    Question(
      text: "2 x 5 =",
      options: ["10", "12", "8", "15"],
      correctIndex: 0,
    ),
    Question(text: "12 / 3 =", options: ["2", "3", "4", "5"], correctIndex: 2),
    Question(
      text: "¿Número par?",
      options: ["7", "9", "10", "11"],
      correctIndex: 2,
    ),
  ];
}
