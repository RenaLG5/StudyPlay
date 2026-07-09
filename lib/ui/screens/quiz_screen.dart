import 'package:flutter/material.dart';
import '/models/quiz_model.dart';
import '/models/game_result.dart';
import '../../viewmodels/history_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';

import '/controller/achievement_controller.dart';

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
      final beforeMath = progressVM.progress.mathLevel;
      final beforeScience = progressVM.progress.scienceLevel;
      final beforeLanguage = progressVM.progress.languageLevel;
      final beforeHistory = progressVM.progress.historyLevel;

      await progressVM.registerQuizResult(widget.title, passed);

      await Future.delayed(const Duration(milliseconds: 50));

      final afterMath = progressVM.progress.mathLevel;
      final afterScience = progressVM.progress.scienceLevel;
      final afterLanguage = progressVM.progress.languageLevel;
      final afterHistory = progressVM.progress.historyLevel;

      if (widget.title == "Matemáticas") {
        if (beforeMath == 3 && afterMath == 4) {
          achievements.add("Matemático");
          //await SoundService.reward();
        }

        if (beforeMath == 5 && afterMath == 5) {
          achievements.add("Genio Matemático");
          //await SoundService.victory();
        }
      }

      if (widget.title == "Lenguaje") {
        if (beforeLanguage == 3 && afterLanguage == 4) {
          achievements.add("Lector Experto");
          //await SoundService.reward();
        }

        if (beforeLanguage == 5 && afterLanguage == 5) {
          achievements.add("Maestro del Lenguaje");
          //await SoundService.victory();
        }
      }

      if (widget.title == "Ciencias") {
        if (beforeScience == 3 && afterScience == 4) {
          achievements.add("Científico");
          //await SoundService.reward();
        }

        if (beforeScience == 5 && afterScience == 5) {
          achievements.add("Científico Experto");
          //await SoundService.victory();
        }
      }

      if (widget.title == "Historia") {
        if (beforeHistory == 3 && afterHistory == 4) {
          achievements.add("Historiador");
          //await SoundService.reward();
        }

        if (beforeHistory == 5 && afterHistory == 5) {
          achievements.add("Historiador Experto");
          //await SoundService.victory();
        }
      }

      if (afterMath >= 5 &&
          afterLanguage >= 5 &&
          afterScience >= 5 &&
          afterHistory >= 5) {
        achievements.add("Dominador de StudyPlay");
        //await SoundService.victory();
      }
    }

    final totalVictories = historyVM.results.where((e) => e.isVictory).length;

    if (totalVictories == 1) {
      achievements.add("Primer Paso");
      //await SoundService.reward();
    }
    if (totalVictories == 5) {
      achievements.add("Aprendiz");
      //await SoundService.reward();
    }
    if (totalVictories == 10) {
      achievements.add("Estudiante Experto");
      //await SoundService.reward();
    }
    if (totalVictories == 20) {
      achievements.add("Maestro del Conocimiento");
      //await SoundService.reward();
    }

    for (final title in achievements) {
      AchievementService.show(context, title);
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

    final subjectWins = historyVM.results
        .where((e) => e.isVictory && e.subject == widget.title)
        .length;

    AchievementController.check(
      context: context,
      achievements: achievements
          .map((e) => {"title": e, "unlocked": true})
          .toList(),
      subject: widget.title,
      subjectWins: subjectWins,
    );
  }

  List<Map<String, dynamic>> buildAchievements(
    HistoryViewModel historyVM,
    ProgressViewModel progressVM,
  ) {
    final totalCompleted = historyVM.results.where((e) => e.isVictory).length;

    return [
      {"title": "Primer Paso", "unlocked": totalCompleted >= 1},
      {"title": "Aprendiz", "unlocked": totalCompleted >= 5},
      {"title": "Estudiante Experto", "unlocked": totalCompleted >= 10},
      {"title": "Matemático", "unlocked": progressVM.progress.mathLevel >= 3},
    ];
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
