import '/models/quiz_model.dart';

class HistoryQuestions {
  static Map<int, List<Question>> levels = {
    // NIVEL 1
    1: [
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
    ],

    // NIVEL 2
    2: [
      Question(
        text: "¿Quién fue Napoleón?",
        options: [
          "Un emperador francés",
          "Un científico",
          "Un pintor",
          "Un rey español",
        ],
        correctIndex: 0,
      ),

      Question(
        text: "¿Dónde nació la democracia?",
        options: ["Roma", "Egipto", "Grecia", "China"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Quién escribió la Ilíada?",
        options: ["Sócrates", "Homero", "Platón", "Aristóteles"],
        correctIndex: 1,
      ),

      Question(
        text: "Capital del Imperio Romano:",
        options: ["Atenas", "Roma", "París", "Madrid"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Quién fue Simón Bolívar?",
        options: ["Un explorador", "Un libertador", "Un rey", "Un pintor"],
        correctIndex: 1,
      ),
    ],

    // NIVEL 3
    3: [
      Question(
        text: "¿En qué año llegó Colón a América?",
        options: ["1492", "1500", "1810", "1789"],
        correctIndex: 0,
      ),

      Question(
        text: "¿Qué civilización creó Machu Picchu?",
        options: ["Aztecas", "Mayas", "Incas", "Romanos"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Quién fue el primer emperador romano?",
        options: ["Julio César", "Augusto", "Nerón", "Trajano"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál fue la Edad Media?",
        options: [
          "Periodo entre Antigua y Moderna",
          "Época actual",
          "Edad de Piedra",
          "Siglo XX",
        ],
        correctIndex: 0,
      ),

      Question(
        text: "¿Quién descubrió la penicilina?",
        options: ["Newton", "Darwin", "Fleming", "Einstein"],
        correctIndex: 2,
      ),
    ],

    // NIVEL 4
    4: [
      Question(
        text: "¿Qué ocurrió en 1789?",
        options: [
          "Descubrimiento de América",
          "Revolución Francesa",
          "Primera Guerra Mundial",
          "Independencia de Chile",
        ],
        correctIndex: 1,
      ),

      Question(
        text: "¿Quién fue Julio César?",
        options: [
          "Emperador chino",
          "Líder romano",
          "Rey francés",
          "Filósofo griego",
        ],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué país construyó la Gran Muralla?",
        options: ["Japón", "India", "China", "Corea"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Quién pintó la Mona Lisa?",
        options: ["Miguel Ángel", "Da Vinci", "Picasso", "Van Gogh"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué guerra ocurrió entre 1914 y 1918?",
        options: [
          "Segunda Guerra Mundial",
          "Guerra Fría",
          "Primera Guerra Mundial",
          "Guerra Civil Española",
        ],
        correctIndex: 2,
      ),
    ],

    // NIVEL 5
    5: [
      Question(
        text: "¿En qué año comenzó la Segunda Guerra Mundial?",
        options: ["1935", "1939", "1945", "1918"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Quién fue el primer presidente de Chile?",
        options: [
          "Arturo Prat",
          "Manuel Bulnes",
          "Manuel Blanco Encalada",
          "Bernardo O'Higgins",
        ],
        correctIndex: 2,
      ),

      Question(
        text: "¿Qué civilización inventó el papel?",
        options: ["Egipcios", "Romanos", "Griegos", "Chinos"],
        correctIndex: 3,
      ),

      Question(
        text: "¿Quién fue Sócrates?",
        options: [
          "Filósofo griego",
          "Rey romano",
          "Explorador",
          "General francés",
        ],
        correctIndex: 0,
      ),

      Question(
        text: "¿Qué acontecimiento marcó el fin de la Edad Media?",
        options: [
          "Caída de Roma",
          "Descubrimiento de América",
          "Primera Guerra Mundial",
          "Revolución Francesa",
        ],
        correctIndex: 1,
      ),
    ],
  };
}
