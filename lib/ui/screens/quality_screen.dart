import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../viewmodels/quality_viewmodel.dart';

class QualityScreen extends StatefulWidget {
  const QualityScreen({super.key});

  @override
  State<QualityScreen> createState() => _QualityScreenState();
}

class _QualityScreenState extends State<QualityScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<QualityViewModel>().loadQuestions();
    });
  }

  Future<void> sendSurvey() async {
    final vm = context.read<QualityViewModel>();

    String body = '';

    for (var q in vm.questions) {
      body += '${q.question}: ${q.answer}/5\n';
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'rleon23@alumnos.utalca.cl',
      query: 'subject=Encuesta StudyPlay&body=$body',
    );

    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<QualityViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Encuesta de Calidad')),

      body: vm.questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.questions.length,

                    itemBuilder: (context, index) {
                      final question = vm.questions[index];

                      return Card(
                        margin: const EdgeInsets.all(10),

                        child: Padding(
                          padding: const EdgeInsets.all(15),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                question.question,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Slider(
                                value: question.answer.toDouble(),

                                min: 1,

                                max: 5,

                                divisions: 4,

                                label: question.answer.toString(),

                                onChanged: (value) {
                                  vm.answerQuestion(index, value.toInt());
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),

                  child: ElevatedButton.icon(
                    onPressed: vm.allAnswered ? sendSurvey : null,

                    icon: const Icon(Icons.send),

                    label: const Text('Enviar'),
                  ),
                ),
              ],
            ),
    );
  }
}
