import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '/data/math_questions.dart';
import '/data/language_questions.dart';
import '/data/science_questions.dart';
import '/data/history_questions.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materias')),

      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSubject(
                context,
                title: 'Matemáticas',
                color: Colors.blue,
                icon: Icons.calculate,
              ),

              _buildSubject(
                context,
                title: 'Lenguaje',
                color: Colors.red,
                icon: Icons.menu_book,
              ),

              _buildSubject(
                context,
                title: 'Ciencias',
                color: Colors.green,
                icon: Icons.science,
              ),

              _buildSubject(
                context,
                title: 'Historia',
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
                title: "Matemática",
                questions: MathQuestions.list,
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
                questions: LanguageQuestions.list,
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
                questions: ScienceQuestions.list,
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
                questions: HistoryQuestions.list,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
