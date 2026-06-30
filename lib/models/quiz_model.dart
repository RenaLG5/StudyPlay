class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });

  factory Question.fromFirestore(Map<String, dynamic> data) {
    return Question(
      text: data["text"] ?? "",
      options: List<String>.from(data["options"] ?? []),
      correctIndex: data["correctIndex"] ?? 0,
    );
  }
}
