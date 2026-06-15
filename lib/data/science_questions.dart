import '/models/quiz_model.dart';

class ScienceQuestions {
  static Map<int, List<Question>> levels = {
    // NIVEL 1
    1: [
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
    ],

    // NIVEL 2
    2: [
      Question(
        text: "¿Cuál es el planeta más grande?",
        options: ["Marte", "Saturno", "Júpiter", "Venus"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Qué órgano usamos para respirar?",
        options: ["Corazón", "Pulmones", "Riñones", "Hígado"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué estrella ilumina la Tierra?",
        options: ["Luna", "Sirio", "Sol", "Marte"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es el hueso más largo del cuerpo?",
        options: ["Fémur", "Costilla", "Radio", "Tibia"],
        correctIndex: 0,
      ),

      Question(
        text: "¿Qué animal es mamífero?",
        options: ["Tiburón", "Delfín", "Lagarto", "Águila"],
        correctIndex: 1,
      ),
    ],

    // NIVEL 3
    3: [
      Question(
        text: "¿Qué gas producen las plantas?",
        options: ["CO2", "Oxígeno", "Helio", "Metano"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuántos planetas tiene el Sistema Solar?",
        options: ["7", "8", "9", "10"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué fuerza nos mantiene en la Tierra?",
        options: ["Electricidad", "Presión", "Gravedad", "Magnetismo"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es el símbolo químico del agua?",
        options: ["O2", "CO2", "H2O", "HO"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Qué planeta tiene anillos?",
        options: ["Mercurio", "Marte", "Saturno", "Venus"],
        correctIndex: 2,
      ),
    ],

    // NIVEL 4
    4: [
      Question(
        text: "¿Quién formuló la ley de gravedad?",
        options: ["Einstein", "Darwin", "Newton", "Galileo"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es la velocidad aproximada de la luz?",
        options: ["300 km/s", "30.000 km/s", "300.000 km/s", "3.000 km/s"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es el planeta más cercano al Sol?",
        options: ["Venus", "Mercurio", "Marte", "Tierra"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué científico propuso la evolución?",
        options: ["Newton", "Tesla", "Darwin", "Bohr"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es el órgano más grande del cuerpo humano?",
        options: ["Hígado", "Pulmón", "Piel", "Corazón"],
        correctIndex: 2,
      ),
    ],

    // NIVEL 5
    5: [
      Question(
        text: "¿Cuál es el elemento más abundante del universo?",
        options: ["Oxígeno", "Hierro", "Hidrógeno", "Helio"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Qué estudia la genética?",
        options: [
          "Los planetas",
          "Los genes y la herencia",
          "Los volcanes",
          "Las células",
        ],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál es el centro de un átomo?",
        options: ["Electrón", "Neutrón", "Núcleo", "Protón"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Qué instrumento mide la presión atmosférica?",
        options: ["Termómetro", "Barómetro", "Microscopio", "Anemómetro"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué tipo de energía utiliza un panel solar?",
        options: ["Nuclear", "Eólica", "Solar", "Química"],
        correctIndex: 2,
      ),
    ],
  };
}
