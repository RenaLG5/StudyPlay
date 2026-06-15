import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../viewmodels/quality_viewmodel.dart';
import '../../viewmodels/settings_viewmodel.dart';

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
    final qualityVM = context.read<QualityViewModel>();
    final settingsVM = context.read<SettingsViewModel>();
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    final answers = qualityVM.questions.map((q) {
      return {'question': q.titulo, 'answer': q.valor};
    }).toList();

    await FirebaseFirestore.instance.collection('quality_surveys').add({
      'userName': settingsVM.username.isNotEmpty
          ? settingsVM.username
          : 'Usuario',
      'email': userEmail,
      'country': settingsVM.country,
      'answers': answers,
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Encuesta enviada a Firebase')),
      );
    }
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
                                question.titulo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Slider(
                                value: question.valor.toDouble(),
                                min: 1,
                                max: 5,
                                divisions: 4,
                                label: question.valor.toString(),
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
