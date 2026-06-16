import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_screen.dart';

import '/data/math_questions.dart';
import '/data/language_questions.dart';
import '/data/science_questions.dart';
import '/data/history_questions.dart';

import '/viewmodels/progress_viewmodel.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressVM = Provider.of<ProgressViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Materias'), centerTitle: true),

      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,

          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            children: [
              _buildSubject(
                context,
                title: 'Matemáticas',
                level: progressVM.progress.mathLevel,
                color: Colors.blue,
                icon: Icons.calculate,
              ),

              _buildSubject(
                context,
                title: 'Lenguaje',
                level: progressVM.progress.languageLevel,
                color: Colors.red,
                icon: Icons.menu_book,
              ),

              _buildSubject(
                context,
                title: 'Ciencias',
                level: progressVM.progress.scienceLevel,
                color: Colors.green,
                icon: Icons.science,
              ),

              _buildSubject(
                context,
                title: 'Historia',
                level: progressVM.progress.historyLevel,
                color: Colors.orange,
                icon: Icons.account_balance,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubject(
    BuildContext context, {
    required String title,
    required int level,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        if (title == 'Matemáticas') {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => QuizScreen(
                title: "Matemáticas",

                level: level,

                questions:
                    MathQuestions.levels[level] ?? MathQuestions.levels[1]!,
              ),
            ),
          );
        }

        if (title == 'Lenguaje') {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => QuizScreen(
                title: "Lenguaje",

                level: level,

                questions:
                    LanguageQuestions.levels[level] ??
                    LanguageQuestions.levels[1]!,
              ),
            ),
          );
        }

        if (title == 'Ciencias') {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => QuizScreen(
                title: "Ciencias",

                level: level,

                questions:
                    ScienceQuestions.levels[level] ??
                    ScienceQuestions.levels[1]!,
              ),
            ),
          );
        }

        if (title == 'Historia') {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => QuizScreen(
                title: "Historia",

                level: level,

                questions:
                    HistoryQuestions.levels[level] ??
                    HistoryQuestions.levels[1]!,
              ),
            ),
          );
        }
      },

      child: Container(
        margin: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          color: color,

          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, size: 60, color: Colors.white),

            const SizedBox(height: 15),

            Text(
              title,

              style: const TextStyle(
                color: Colors.white,

                fontSize: 20,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

              decoration: BoxDecoration(
                color: Colors.white24,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                "Nivel $level",

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 16,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
