import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/viewmodels/feedback_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/load_question.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await loadQuestions(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FeedbackViewModel>(context);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Encuesta")),
        body: const Center(
          child: Text("Debes iniciar sesión para responder la encuesta"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Valoración de Calidad')),

      body: vm.questionsBySection.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...vm.questionsBySection.entries.map((sectionEntry) {
                  final section = sectionEntry.key;
                  final questions = sectionEntry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...questions.asMap().entries.map((qEntry) {
                        final index = qEntry.key;
                        final question = qEntry.value;

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  question.titulo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Slider(
                                  min: 1,
                                  max: 5,
                                  divisions: 4,
                                  value: question.valor == 0
                                      ? 1
                                      : question.valor.toDouble(),
                                  onChanged: (value) {
                                    vm.updateAnswer(
                                      section,
                                      index,
                                      value.toInt(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: vm.allAnswered
                      ? () {
                          vm.sendFeedback(
                            user.displayName ?? "Usuario",
                            user.email ?? "",
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Encuesta enviada"),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      : null,
                  icon: const Icon(Icons.send),
                  label: const Text("Enviar"),
                ),
              ],
            ),
    );
  }
}
