import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../viewmodels/feedback_viewmodel.dart';

Future<void> loadQuestions(BuildContext context) async {
  final jsonString = await rootBundle.loadString(
    'assets/data/qa_questions.json',
  );

  final Map<String, dynamic> jsonData = json.decode(jsonString);

  Provider.of<FeedbackViewModel>(context, listen: false).loadFromJson(jsonData);
}
