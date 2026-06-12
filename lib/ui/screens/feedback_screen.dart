import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/feedback_viewmodel.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FeedbackViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Valoración de Calidad')),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vm.questions.length + 1,

        itemBuilder: (context, index) {
          if (index == vm.questions.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),

              child: ElevatedButton.icon(
                onPressed: vm.allAnswered ? () => vm.sendFeedback() : null,

                icon: const Icon(Icons.send),

                label: const Text('Enviar'),
              ),
            );
          }

          final question = vm.questions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),

            child: Padding(
              padding: const EdgeInsets.all(15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    question.text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: question.answer.toDouble(),

                    label: question.answer.toString(),

                    onChanged: (value) {
                      vm.updateAnswer(index, value.toInt());
                    },
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
