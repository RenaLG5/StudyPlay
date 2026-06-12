import '/models/quiz_model.dart';

class ScienceQuestions {
  static List<Question> list = [
    Question(
      text: "Planeta rojo:",
      options: ["Venus", "Marte", "Júpiter", "Tierra"],
      correctIndex: 1,
    ),
    Question(
      text: "Las plantas necesitan:",
      options: ["Plástico", "Luz", "Piedra", "Metal"],
      correctIndex: 1,
    ),
    Question(
      text: "Estado del agua:",
      options: ["Sólido", "Luz", "Fuego", "Sonido"],
      correctIndex: 0,
    ),
    Question(
      text: "Corazón:",
      options: ["Respira", "Bombea sangre", "Piensa", "Ve"],
      correctIndex: 1,
    ),
    Question(
      text: "Gas que respiramos:",
      options: ["Oxígeno", "CO2", "Helio", "Nitrógeno"],
      correctIndex: 0,
    ),
  ];
}
