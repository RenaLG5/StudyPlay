import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> achievements = const [
    {
      'title': 'Primer paso',
      'description': 'Completa tu primer quiz',
      'icon': Icons.flag,
      'unlocked': true,
    },
    {
      'title': 'Racha 5 días',
      'description': 'Estudia 5 días seguidos',
      'icon': Icons.local_fire_department,
      'unlocked': true,
    },
    {
      'title': 'Racha 10 días',
      'description': 'Estudia 10 días seguidos',
      'icon': Icons.local_fire_department,
      'unlocked': false,
    },
    {
      'title': 'Racha 50 días',
      'description': 'Estudia 50 días seguidos',
      'icon': Icons.whatshot,
      'unlocked': false,
    },
    {
      'title': 'Matemático Pro',
      'description': 'Completa 10 quizzes de Matemáticas',
      'icon': Icons.calculate,
      'unlocked': true,
    },
    {
      'title': 'Científico',
      'description': 'Completa 10 quizzes de Ciencias',
      'icon': Icons.science,
      'unlocked': false,
    },
    {
      'title': 'Historiador',
      'description': 'Completa 10 quizzes de Historia',
      'icon': Icons.account_balance,
      'unlocked': false,
    },
    {
      'title': 'Lector Experto',
      'description': 'Completa 10 quizzes de Lenguaje',
      'icon': Icons.menu_book,
      'unlocked': true,
    },
    {
      'title': 'Aprendiz Constante',
      'description': 'Completa 50 quizzes en total',
      'icon': Icons.star,
      'unlocked': false,
    },
    {
      'title': 'Maestro del Conocimiento',
      'description': 'Completa 100 quizzes',
      'icon': Icons.emoji_events,
      'unlocked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recompensas'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          final bool unlocked = achievement['unlocked'];

          return Card(
            color: unlocked ? Colors.amber[100] : Colors.grey[300],
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(
                achievement['icon'],
                size: 40,
                color: unlocked ? Colors.orange : Colors.grey,
              ),
              title: Text(
                achievement['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: unlocked ? Colors.black : Colors.grey,
                ),
              ),
              subtitle: Text(
                achievement['description'],
                style: TextStyle(
                  color: unlocked ? Colors.black87 : Colors.grey,
                ),
              ),
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
