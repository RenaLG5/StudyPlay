const admin = require("firebase-admin/app");
const { getFirestore, FieldValue } = require("firebase-admin/firestore");
const fs = require("fs");

const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.cert(serviceAccount),
});

const db = getFirestore();

const filePath = "./tools/questions/1_matematicas.json";

const COURSE = 1;
const SUBJECT = "Matemáticas";
const QUESTIONS_PER_LEVEL = 5;

async function uploadQuestions() {
  const rawData = fs.readFileSync(filePath, "utf8");
  const jsonData = JSON.parse(rawData);

  const questions = jsonData.questions;

  for (let i = 0; i < questions.length; i++) {
    const q = questions[i];

    const level = Math.floor(i / QUESTIONS_PER_LEVEL) + 1;

    const docId = `course_${COURSE}_matematicas_level_${level}_q_${i + 1}`;

    const questionData = {
      course: COURSE,
      subject: SUBJECT,
      level: level,
      text: q.text,
      options: q.options,
      correctIndex: q.correctIndex,
      createdAt: FieldValue.serverTimestamp(),
    };

    await db.collection("questions").doc(docId).set(questionData);

    console.log(`Subida: ${docId}`);
  }

  console.log("Todas las preguntas fueron subidas correctamente.");
}

uploadQuestions().catch((error) => {
  console.error("Error al subir preguntas:", error);
});