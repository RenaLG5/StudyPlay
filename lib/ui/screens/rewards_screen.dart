import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/history_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final Set<String> _shownAchievements = {};

  void showAchievementBanner(String title) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 60,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Colors.black45),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Logro desbloqueado: $title",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  void checkNewAchievements(List<Map<String, dynamic>> achievements) {
    for (final a in achievements) {
      final title = a["title"].toString();
      final unlocked = a["unlocked"] == true;

      if (unlocked && !_shownAchievements.contains(title)) {
        _shownAchievements.add(title);
        showAchievementBanner(title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyVM = Provider.of<HistoryViewModel>(context);
    final progressVM = Provider.of<ProgressViewModel>(context);

    final totalCompleted = historyVM.results.where((e) => e.isVictory).length;

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

    final achievements = [
      {
        "title": "Primer Paso",
        "desc": "Completa tu primer nivel",
        "icon": Icons.flag,
        "unlocked": totalCompleted >= 1,
      },
      {
        "title": "Aprendiz",
        "desc": "Completa 5 niveles",
        "icon": Icons.school,
        "unlocked": totalCompleted >= 5,
      },
      {
        "title": "Estudiante Experto",
        "desc": "Completa 10 niveles",
        "icon": Icons.star,
        "unlocked": totalCompleted >= 10,
      },
      {
        "title": "Maestro del Conocimiento",
        "desc": "Completa 20 niveles",
        "icon": Icons.emoji_events,
        "unlocked": totalCompleted >= 20,
      },
      {
        "title": "Matemático",
        "desc": "Completa el nivel 3 en Matemáticas",
        "icon": Icons.calculate,
        "unlocked": mathWins >= 3,
      },
      {
        "title": "Genio Matemático",
        "desc": "Completa el nivel 5 en Matemáticas",
        "icon": Icons.functions,
        "unlocked": mathWins >= 5,
      },
      {
        "title": "Lector",
        "desc": "Completa el nivel 3 en Lenguaje",
        "icon": Icons.menu_book,
        "unlocked": languageWins >= 3,
      },
      {
        "title": "Lector Experto",
        "desc": "Completa el nivel 5 en Lenguaje",
        "icon": Icons.auto_stories,
        "unlocked": languageWins >= 5,
      },
      {
        "title": "Científico",
        "desc": "Completa el nivel 3 en Ciencias",
        "icon": Icons.science,
        "unlocked": scienceWins >= 3,
      },
      {
        "title": "Científico Experto",
        "desc": "Completa el nivel 5 en Ciencias",
        "icon": Icons.biotech,
        "unlocked": scienceWins >= 5,
      },
      {
        "title": "Historiador",
        "desc": "Completa el nivel 3 en Historia",
        "icon": Icons.account_balance,
        "unlocked": historyWins >= 3,
      },
      {
        "title": "Historiador Experto",
        "desc": "Completa el nivel 5 en Historia",
        "icon": Icons.history_edu,
        "unlocked": historyWins >= 5,
      },
      {
        "title": "Dominador de StudyPlay",
        "desc": "Completa el nivel 5 en todas las materias",
        "icon": Icons.workspace_premium,
        "unlocked":
            mathWins >= 5 &&
            languageWins >= 5 &&
            scienceWins >= 5 &&
            historyWins >= 5,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Recompensas"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          final unlocked = achievement["unlocked"] as bool;

          return Card(
            elevation: unlocked ? 6 : 1,
            color: unlocked ? Colors.amber[100] : Colors.grey[300],
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: unlocked ? Colors.orange : Colors.grey,
                child: Icon(
                  achievement["icon"] as IconData,
                  color: Colors.white,
                ),
              ),
              title: Text(
                achievement["title"].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: unlocked ? Colors.black : Colors.grey[700],
                ),
              ),
              subtitle: Text(achievement["desc"].toString()),
              trailing: Icon(
                unlocked ? Icons.check_circle : Icons.lock,
                color: unlocked ? Colors.green : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
