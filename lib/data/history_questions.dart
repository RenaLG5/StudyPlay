import '/models/quiz_model.dart';

class HistoryQuestions {
  static List<Question> list = [
    Question(
      text: "Descubrió América:",
      options: ["Colón", "Einstein", "Napoleón", "Bolívar"],
      correctIndex: 0,
    ),
    Question(
      text: "Torre Eiffel en:",
      options: ["Italia", "Francia", "España", "Chile"],
      correctIndex: 1,
    ),
    Question(
      text: "Pirámides:",
      options: ["Egipcios", "Romanos", "Griegos", "Chinos"],
      correctIndex: 0,
    ),
    Question(
      text: "Historia es:",
      options: ["Futuro", "Pasado", "Ciencia", "Juego"],
      correctIndex: 1,
    ),
    Question(
      text: "Vikingos en:",
      options: ["Chile", "Noruega", "Brasil", "India"],
      correctIndex: 1,
    ),
  ];
}
