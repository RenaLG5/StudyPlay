import '/models/quiz_model.dart';

class MathQuestions {
  static Map<int, List<Question>> levels = {
    // NIVEL 1
    1: [
      Question(text: "3 + 3 =", options: ["5", "6", "7", "8"], correctIndex: 1),

      Question(
        text: "10 - 4 =",
        options: ["5", "6", "7", "4"],
        correctIndex: 1,
      ),

      Question(
        text: "2 × 5 =",
        options: ["10", "12", "8", "15"],
        correctIndex: 0,
      ),

      Question(
        text: "12 ÷ 3 =",
        options: ["2", "3", "4", "5"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es un número par?",
        options: ["7", "9", "10", "11"],
        correctIndex: 2,
      ),
    ],

    // NIVEL 2
    2: [
      Question(
        text: "15 + 8 =",
        options: ["21", "22", "23", "24"],
        correctIndex: 2,
      ),

      Question(
        text: "20 - 13 =",
        options: ["5", "6", "7", "8"],
        correctIndex: 2,
      ),

      Question(
        text: "6 × 7 =",
        options: ["42", "36", "48", "56"],
        correctIndex: 0,
      ),

      Question(
        text: "25 ÷ 5 =",
        options: ["4", "5", "6", "7"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál es mayor?",
        options: ["45", "54", "35", "44"],
        correctIndex: 1,
      ),
    ],

    // NIVEL 3
    3: [
      Question(
        text: "14 × 3 =",
        options: ["42", "36", "48", "40"],
        correctIndex: 0,
      ),

      Question(
        text: "120 ÷ 10 =",
        options: ["10", "11", "12", "14"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuánto es 15²?",
        options: ["125", "225", "215", "250"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál es un número primo?",
        options: ["9", "15", "17", "21"],
        correctIndex: 2,
      ),

      Question(
        text: "7 × 8 - 10 =",
        options: ["46", "48", "52", "50"],
        correctIndex: 0,
      ),
    ],

    // NIVEL 4
    4: [
      Question(text: "√81 =", options: ["7", "8", "9", "10"], correctIndex: 2),

      Question(
        text: "25% de 200 =",
        options: ["25", "50", "75", "100"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuánto es 18²?",
        options: ["324", "244", "342", "288"],
        correctIndex: 0,
      ),

      Question(
        text: "¿Cuánto es 2³?",
        options: ["4", "6", "8", "16"],
        correctIndex: 2,
      ),

      Question(
        text: "5 * (8 + 1) ¿Cuál es el resultado?",
        options: ["40", "45", "50", "55"],
        correctIndex: 1,
      ),
    ],

    // NIVEL 5
    5: [
      Question(
        text: "Si x = 4, ¿cuánto vale 3x + 2?",
        options: ["10", "12", "14", "16"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuánto es 7³?",
        options: ["343", "243", "441", "294"],
        correctIndex: 0,
      ),

      Question(
        text: "¿Cuál es el área de un cuadrado de lado 9?",
        options: ["18", "36", "72", "81"],
        correctIndex: 3,
      ),

      Question(
        text: "¿Cuál es el perímetro de un triángulo con lados 4, 5 y 6?",
        options: ["13", "14", "15", "16"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuánto es 150 ÷ 0.5?",
        options: ["75", "150", "200", "300"],
        correctIndex: 3,
      ),
    ],
  };
}
