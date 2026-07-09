import 'package:flutter/material.dart';
import '/models/quiz_model.dart';
import '/models/game_result.dart';
import '../../viewmodels/history_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';

import '/services/sound_service.dart';
import '/services/achviement_service.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Question> questions;
  final int level;

  const QuizScreen({
    super.key,
    required this.title,
    required this.questions,
    required this.level,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  DateTime? startTime;

  final achievements = <String>[];

  int index = 0;
  int score = 0;
  int? selected;
  bool _waitingNext = false;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  void answer(int i) async {
    if (selected != null || _waitingNext) return;

    final isCorrect = i == widget.questions[index].correctIndex;

    setState(() {
      selected = i;
      _waitingNext = true;
      if (isCorrect) score++;
    });

    if (isCorrect) {
      await SoundService.correct();
      await HapticsService.correct();
    } else {
      await SoundService.wrong();
      await HapticsService.wrong();
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      _waitingNext = false;
      next();
    });
  }

  void next() {
    if (index < widget.questions.length - 1) {
      setState(() {
        index++;
        selected = null;
      });
    } else {
      showResult();
    }
  }

  void showResult() async {
    final historyVM = Provider.of<HistoryViewModel>(context, listen: false);
    final progressVM = Provider.of<ProgressViewModel>(context, listen: false);

    final settingsVM = Provider.of<SettingsViewModel>(context, listen: false);
    final achievements = <String>[];

    final endTime = DateTime.now();
    final duration = endTime.difference(startTime!);

    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final timeSpent =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    final passed = score >= (widget.questions.length * 0.7).ceil();

    final game = GameResult(
      date: DateTime.now().toString().substring(0, 10),
      timeSpent: timeSpent,
      isVictory: passed,
      difficulty: "Nivel ${widget.level}",
      subject: widget.title,
      correctAnswers: score,
      wrongAnswers: widget.questions.length - score,
      level: widget.level,
      course: settingsVM.selectedCourse,
    );

    historyVM.addResult(game);

    if (passed) {
      await progressVM.registerQuizResult(widget.title, passed);
    }

    final totalVictories = historyVM.results.where((e) => e.isVictory).length;
    final totalPlayed = historyVM.results.length;

    final perfectGames = historyVM.results
        .where((e) => e.isVictory && e.wrongAnswers == 0)
        .length;

    final mathWins = historyVM.results
        .where((e) => e.isVictory && e.subject == "Matemáticas")
        .length;

    final languageWins = historyVM.results
        .where((e) => e.isVictory && e.subject == "Lenguaje")
        .length;

    final scienceWins = historyVM.results
        .where((e) => e.isVictory && e.subject == "Ciencias")
        .length;

    final historyWins = historyVM.results
        .where((e) => e.isVictory && e.subject == "Historia")
        .length;

    final course1Wins = historyVM.results
        .where((e) => e.isVictory && e.course == 1)
        .length;

    final course2Wins = historyVM.results
        .where((e) => e.isVictory && e.course == 2)
        .length;

    final course3Wins = historyVM.results
        .where((e) => e.isVictory && e.course == 3)
        .length;

    final course4Wins = historyVM.results
        .where((e) => e.isVictory && e.course == 4)
        .length;

    final course5Wins = historyVM.results
        .where((e) => e.isVictory && e.course == 5)
        .length;

    final course6Wins = historyVM.results
        .where((e) => e.isVictory && e.course == 6)
        .length;

    if (totalVictories == 1) achievements.add("Primer Paso");
    if (totalVictories == 5) achievements.add("Aprendiz");
    if (totalVictories == 10) achievements.add("Estudiante Experto");
    if (totalVictories == 20) achievements.add("Maestro del Conocimiento");

    if (totalPlayed == 30) achievements.add("Constancia");

    if (perfectGames == 3) achievements.add("Perfeccionista");
    if (perfectGames == 10) achievements.add("Imparable");

    if (mathWins == 3) achievements.add("Matemático");
    if (mathWins == 5) achievements.add("Genio Matemático");

    if (languageWins == 3) achievements.add("Lector");
    if (languageWins == 5) achievements.add("Lector Experto");

    if (scienceWins == 3) achievements.add("Científico");
    if (scienceWins == 5) achievements.add("Científico Experto");

    if (historyWins == 3) achievements.add("Historiador");
    if (historyWins == 5) achievements.add("Historiador Experto");

    if (course1Wins == 5) achievements.add("Inicio Escolar");
    if (course2Wins == 5) achievements.add("Segundo Escalón");
    if (course3Wins == 5) achievements.add("Tercer Desafío");
    if (course4Wins == 5) achievements.add("Cuarto Avance");
    if (course5Wins == 5) achievements.add("Quinto Nivel");
    if (course6Wins == 5) achievements.add("Sexto Dominado");

    if (mathWins == 5 &&
        languageWins == 5 &&
        scienceWins == 5 &&
        historyWins == 5) {
      achievements.add("Dominador de StudyPlay");
    }

    if (course1Wins == 5 &&
        course2Wins == 5 &&
        course3Wins == 5 &&
        course4Wins == 5 &&
        course5Wins == 5 &&
        course6Wins == 5) {
      achievements.add("Camino Completo");
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(passed ? "¡Nivel completado!" : "Nivel fallado"),
        content: Text("Obtuviste ${score}/${widget.questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Volver"),
          ),
        ],
      ),
    );
  }

  Color color(int i) {
    final q = widget.questions[index];

    if (selected == null) return Colors.blue;
    if (i == q.correctIndex) return Colors.green;
    if (i == selected) return Colors.red;
    return Colors.grey;
  }

  String _levelText(ProgressViewModel progressVM) {
    int level;
    bool completed;

    switch (widget.title) {
      case "Matemáticas":
        level = progressVM.progress.mathLevel;
        completed = progressVM.progress.mathCompleted;
        break;
      case "Lenguaje":
        level = progressVM.progress.languageLevel;
        completed = progressVM.progress.languageCompleted;
        break;
      case "Ciencias":
        level = progressVM.progress.scienceLevel;
        completed = progressVM.progress.scienceCompleted;
        break;
      case "Historia":
        level = progressVM.progress.historyLevel;
        completed = progressVM.progress.historyCompleted;
        break;
      default:
        level = 1;
        completed = false;
    }

    return completed ? "Completado" : "Nivel $level";
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[index];
    final progressVM = Provider.of<ProgressViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} - ${_levelText(progressVM)}"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            q.text,
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "Pregunta ${index + 1}/${widget.questions.length}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: q.options.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => answer(i),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color(i),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        q.options[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
