import 'package:flutter/material.dart';
import '/models/quiz_model.dart';
import '/models/game_result.dart';
import '../../viewmodels/history_viewmodel.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Question> questions;

  const QuizScreen({super.key, required this.title, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  DateTime? startTime;

  int index = 0;
  int score = 0;
  int? selected;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now(); // ⏱ inicia el tiempo
  }

  void answer(int i) {
    if (selected != null) return;

    setState(() {
      selected = i;
      if (i == widget.questions[index].correctIndex) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), next);
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

  void showResult() {
    final historyVM = Provider.of<HistoryViewModel>(context, listen: false);

    final endTime = DateTime.now();
    final duration = endTime.difference(startTime!);

    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final timeSpent =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    final game = GameResult(
      date: DateTime.now().toString().substring(0, 10),
      timeSpent: timeSpent,
      isVictory: score >= widget.questions.length ~/ 2,
      difficulty: "Normal",
      subject: widget.title,
      correctAnswers: score,
      wrongAnswers: widget.questions.length - score,
    );

    historyVM.addResult(game);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Resultado"),
        content: Text("Puntaje: $score / ${widget.questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                index = 0;
                score = 0;
                selected = null;
                startTime = DateTime.now(); // reinicia tiempo
              });
            },
            child: const Text("Reintentar"),
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
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            q.text,
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

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
