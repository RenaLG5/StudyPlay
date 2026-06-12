import '/models/quiz_model.dart';

class LanguageQuestions {
  static List<Question> list = [
    Question(
      text: "Sustantivo:",
      options: ["Correr", "Casa", "Rápido", "Bien"],
      correctIndex: 1,
    ),
    Question(
      text: "Verbo:",
      options: ["Mesa", "Saltar", "Azul", "Alto"],
      correctIndex: 1,
    ),
    Question(
      text: "Antónimo de alto:",
      options: ["Grande", "Bajo", "Largo", "Fuerte"],
      correctIndex: 1,
    ),
    Question(
      text: "Bien escrito:",
      options: ["Hayer", "Ayer", "Aier", "Ayerr"],
      correctIndex: 1,
    ),
    Question(
      text: "Adjetivo:",
      options: ["Rojo", "Correr", "Casa", "Ir"],
      correctIndex: 0,
    ),
  ];
}
