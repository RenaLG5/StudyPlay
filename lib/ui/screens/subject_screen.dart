import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'quiz_screen.dart';

import '/viewmodels/settings_viewmodel.dart';
import '/viewmodels/quiz_questions_viewmodel.dart';
import '/viewmodels/progress_viewmodel.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressVM = Provider.of<ProgressViewModel>(context);
    final settingsVM = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Materias - ${settingsVM.selectedCourse}° básico'),
        centerTitle: true,
      ),
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
                progressVM,
                title: 'Matemáticas',
                level: progressVM.progress.mathLevel,
                color: Colors.blue,
                icon: Icons.calculate,
              ),
              _buildSubject(
                context,
                progressVM,
                title: 'Lenguaje',
                level: progressVM.progress.languageLevel,
                color: Colors.red,
                icon: Icons.menu_book,
              ),
              _buildSubject(
                context,
                progressVM,
                title: 'Ciencias',
                level: progressVM.progress.scienceLevel,
                color: Colors.green,
                icon: Icons.science,
              ),
              _buildSubject(
                context,
                progressVM,
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
    BuildContext context,
    ProgressViewModel progressVM, {
    required String title,
    required int level,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () async {
        final quizVM = Provider.of<QuizQuestionsViewModel>(
          context,
          listen: false,
        );

        final settingsVM = Provider.of<SettingsViewModel>(
          context,
          listen: false,
        );

        final connectivityResult = await Connectivity().checkConnectivity();

        if (connectivityResult.contains(ConnectivityResult.none)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Sin conexión a Internet. Se intentará usar la copia local.",
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }

        final isCompleted = _isSubjectCompleted(title, progressVM);

        if (isCompleted) {
          await quizVM.loadReplayQuestions(
            course: settingsVM.selectedCourse,
            subject: title,
          );
        } else {
          await quizVM.loadQuestions(
            course: settingsVM.selectedCourse,
            subject: title,
            level: level,
          );
        }

        if (quizVM.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(quizVM.errorMessage!)));
          return;
        }

        if (quizVM.questions.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No hay preguntas disponibles")),
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizScreen(
              title: title,
              level: level,
              questions: quizVM.questions,
            ),
          ),
        );
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
                _subjectButtonText(title, level, progressVM),
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

  bool _isSubjectCompleted(String title, ProgressViewModel progressVM) {
    switch (title) {
      case "Matemáticas":
        return progressVM.progress.mathCompleted;
      case "Lenguaje":
        return progressVM.progress.languageCompleted;
      case "Ciencias":
        return progressVM.progress.scienceCompleted;
      case "Historia":
        return progressVM.progress.historyCompleted;
      default:
        return false;
    }
  }

  String _subjectButtonText(
    String title,
    int level,
    ProgressViewModel progressVM,
  ) {
    final completed = _isSubjectCompleted(title, progressVM);

    if (completed) {
      return "Volver a jugar";
    }

    return "Nivel $level";
  }
}
