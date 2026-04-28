import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: const Center(
        child: Text(
          'Aquí aparecerán las preguntas',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
