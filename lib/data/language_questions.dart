import '/models/quiz_model.dart';

class LanguageQuestions {
  static Map<int, List<Question>> levels = {
    // NIVEL 1
    1: [
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
    ],

    // NIVEL 2
    2: [
      Question(
        text: "Sinónimo de feliz:",
        options: ["Triste", "Alegre", "Malo", "Débil"],
        correctIndex: 1,
      ),

      Question(
        text: "Plural de lápiz:",
        options: ["Lápizes", "Lápizs", "Lápices", "Lápicess"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es una palabra aguda?",
        options: ["Árbol", "Canción", "Mesa", "Lápiz"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué signo cierra una pregunta?",
        options: ["¡", "?", "¿", "."],
        correctIndex: 1,
      ),

      Question(
        text: "Completa: El perro ____ rápido.",
        options: ["Corre", "Casa", "Azul", "Mesa"],
        correctIndex: 0,
      ),
    ],

    // NIVEL 3
    3: [
      Question(
        text: "¿Cuál es un pronombre?",
        options: ["Juan", "Él", "Casa", "Bonito"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál palabra es esdrújula?",
        options: ["Camión", "Teléfono", "Papel", "Canción"],
        correctIndex: 1,
      ),

      Question(
        text: "Sinónimo de enorme:",
        options: ["Pequeño", "Gigante", "Bajo", "Lento"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué es un adverbio?",
        options: ["Mesa", "Corre", "Rápidamente", "Niño"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál oración está correcta?",
        options: [
          "Los perro juegan",
          "El perros juega",
          "Los perros juegan",
          "Perro los juegan",
        ],
        correctIndex: 2,
      ),
    ],

    // NIVEL 4
    4: [
      Question(
        text: "¿Qué figura literaria compara usando 'como'?",
        options: ["Metáfora", "Hipérbole", "Símil", "Personificación"],
        correctIndex: 2,
      ),

      Question(
        text: "Antónimo de abundante:",
        options: ["Mucho", "Escaso", "Grande", "Largo"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál tiene tilde?",
        options: ["Arbol", "Mesa", "Árbol", "Perro"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Qué tipo de palabra es 'felizmente'?",
        options: ["Sustantivo", "Verbo", "Adverbio", "Adjetivo"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es una conjunción?",
        options: ["Y", "Casa", "Azul", "Correr"],
        correctIndex: 0,
      ),
    ],

    // NIVEL 5
    5: [
      Question(
        text: "¿Qué es una metáfora?",
        options: [
          "Una exageración",
          "Una comparación sin usar 'como'",
          "Una pregunta",
          "Una descripción",
        ],
        correctIndex: 1,
      ),

      Question(
        text: "¿Cuál es el sujeto en 'María canta una canción'?",
        options: ["Canta", "Canción", "María", "Una"],
        correctIndex: 2,
      ),

      Question(
        text: "¿Cuál es el predicado?",
        options: ["María", "Una", "Canción", "Canta una canción"],
        correctIndex: 3,
      ),

      Question(
        text: "¿Qué tipo de texto cuenta hechos reales?",
        options: ["Narrativo", "Informativo", "Poético", "Dramático"],
        correctIndex: 1,
      ),

      Question(
        text: "¿Qué figura literaria da cualidades humanas a objetos?",
        options: ["Metáfora", "Hipérbole", "Personificación", "Símil"],
        correctIndex: 2,
      ),
    ],
  };
}
