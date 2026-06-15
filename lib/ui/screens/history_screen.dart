import 'package:flutter/material.dart';
import '../../models/game_result.dart';

import 'package:provider/provider.dart';
import '../../viewmodels/history_viewmodel.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

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
    final historyVM = Provider.of<HistoryViewModel>(context);
    final list = historyVM.results;

    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: list.isEmpty
          ? const Center(child: Text("No hay resultados aún"))
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final game = list[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      _getSubjectIcon(game.subject),
                      color: _getSubjectColor(game.subject),
                    ),

                    title: Text(game.subject),
                    subtitle: Text(
                      "Nivel ${game.level}\n"
                      "✔ ${game.correctAnswers} | "
                      "✘ ${game.wrongAnswers}\n"
                      "${game.date}",
                    ),
                    trailing: Text(game.timeSpent),
                  ),
                );
              },
            ),
    );
  }
}
