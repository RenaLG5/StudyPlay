const admin = require("firebase-admin/app");
const { getFirestore, FieldValue } = require("firebase-admin/firestore");
const fs = require("fs");
const path = require("path");

const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.cert(serviceAccount),
});

const db = getFirestore();

const QUESTIONS_FOLDER = path.join(__dirname, "questions");
const QUESTIONS_PER_LEVEL = 5;

const subjectMap = {
  matematicas: "Matemáticas",
  matematica: "Matemáticas",

  lenguaje: "Lenguaje",
  lengua: "Lenguaje",

  ciencias: "Ciencias",
  ciencia: "Ciencias",
  ciencias_naturales: "Ciencias",

  historia: "Historia",
  historia_geografia: "Historia",
  historia_y_geografia: "Historia",
  historia_geografia_ciencias_sociales: "Historia",
};

function normalizeText(text) {
  return text
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");
}

async function uploadAllQuestions() {
  const files = fs
    .readdirSync(QUESTIONS_FOLDER)
    .filter((file) => file.endsWith(".json"));

  console.log(`Archivos encontrados: ${files.length}`);

  for (const file of files) {
    const fileName = file.replace(".json", "");
    const parts = fileName.split("_");

    const course = Number(parts[0]);
    const subjectKey = parts.slice(1).join("_");
    const subject = subjectMap[subjectKey];

    console.log({
    archivo: file,
    course,
    subjectKey,
    subject,
    });

    if (!course || !subject) {
      console.log(`Archivo ignorado: ${file}`);
      continue;
    }

    const filePath = path.join(QUESTIONS_FOLDER, file);
    const rawData = fs.readFileSync(filePath, "utf8");
    const jsonData = JSON.parse(rawData);

    const questions = jsonData.questions;

    if (!Array.isArray(questions)) {
      console.log(`Formato inválido: ${file}`);
      continue;
    }

    console.log(`Subiendo ${questions.length} preguntas: ${course}° básico - ${subject}`);

    for (let i = 0; i < questions.length; i++) {
      const q = questions[i];

      const level = Math.floor(i / QUESTIONS_PER_LEVEL) + 1;
      const questionNumber = i + 1;

      const safeSubject = normalizeText(subjectKey);

      const docId = `course_${course}_${safeSubject}_level_${level}_q_${questionNumber}`;

      await db.collection("questions").doc(docId).set({
        course: course,
        subject: subject,
        subjectKey: subjectKey,
        level: level,
        questionNumber: questionNumber,
        text: q.text,
        options: q.options,
        correctIndex: q.correctIndex,
        createdAt: FieldValue.serverTimestamp(),
      });

      console.log(`Subida: ${docId}`);
    }
  }

  console.log("Todas las preguntas fueron subidas correctamente.");
}

uploadAllQuestions().catch((error) => {
  console.error("Error al subir preguntas:", error);
});