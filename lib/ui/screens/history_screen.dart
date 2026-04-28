import 'package:flutter/material.dart';
import '../../models/game_result.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final List<GameResult> listMaqueta = [
    GameResult(
      date: '30 Mar',
      timeSpent: '03:55',
      isVictory: false,
      difficulty: 'Fácil',
      subject: 'Matemáticas',
      correctAnswers: 5,
      wrongAnswers: 3,
    ),
    GameResult(
      date: '31 Mar',
      timeSpent: '02:25',
      isVictory: true,
      difficulty: 'Medio',
      subject: 'Ciencias',
      correctAnswers: 8,
      wrongAnswers: 1,
    ),
    GameResult(
      date: '01 Abr',
      timeSpent: '04:00',
      isVictory: false,
      difficulty: 'Difícil',
      subject: 'Historia',
      correctAnswers: 4,
      wrongAnswers: 6,
    ),
    GameResult(
      date: '02 Abr',
      timeSpent: '01:35',
      isVictory: true,
      difficulty: 'Fácil',
      subject: 'Lenguaje',
      correctAnswers: 9,
      wrongAnswers: 0,
    ),
  ];

  Color _getSubjectColor(String subject) {
    switch (subject) {
      case 'Matemáticas':
        return Colors.blue;
      case 'Lenguaje':
        return Colors.red;
      case 'Ciencias':
        return Colors.green;
      case 'Historia':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getSubjectIcon(String subject) {
    switch (subject) {
      case 'Matemáticas':
        return Icons.calculate;
      case 'Lenguaje':
        return Icons.menu_book;
      case 'Ciencias':
        return Icons.science;
      case 'Historia':
        return Icons.account_balance;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: listMaqueta.length,
        itemBuilder: (context, index) {
          final game = listMaqueta[index];

          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tiempo: ${game.timeSpent}'),
                        Text('Dificultad: ${game.difficulty}'),

                        const SizedBox(height: 10),

                        Text('✔ Correctas: ${game.correctAnswers}'),
                        Text('✘ Incorrectas: ${game.wrongAnswers}'),

                        const SizedBox(height: 10),

                        Text(
                          game.date,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _getSubjectColor(game.subject),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getSubjectIcon(game.subject),
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
