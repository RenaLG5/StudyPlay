import 'package:flutter/material.dart';
import '/models/quiz_model.dart';
import '/models/game_result.dart';
import '../../viewmodels/history_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import 'package:provider/provider.dart';

import '/services/sound_service.dart';

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

    final endTime = DateTime.now();

    final duration = endTime.difference(startTime!);

    final minutes = duration.inMinutes.remainder(60);

    final seconds = duration.inSeconds.remainder(60);

    final timeSpent =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    bool passed = score == widget.questions.length;

    final game = GameResult(
      date: DateTime.now().toString().substring(0, 10),

      timeSpent: timeSpent,

      isVictory: passed,

      difficulty: "Nivel ${widget.level}",

      subject: widget.title,

      correctAnswers: score,

      wrongAnswers: widget.questions.length - score,

      level: widget.level,
    );

    historyVM.addResult(game);

    if (passed) {
      await progressVM.levelUp(widget.title);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(passed ? "¡Nivel completado!" : "Nivel fallado"),

        content: Text(
          passed
              ? "Obtuviste ${score}/${widget.questions.length}\nDesbloqueaste el siguiente nivel."
              : "Obtuviste ${score}/${widget.questions.length}\nDebes responder TODAS correctamente.",
        ),

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

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[index];

    return Scaffold(
      appBar: AppBar(title: Text("${widget.title} - Nivel ${widget.level}")),
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
