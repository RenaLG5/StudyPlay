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
      text: data['text'] ?? '',
      options: List<String>.from(data['options'] ?? []),
      correctIndex: data['correctIndex'] ?? 0,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correctIndex'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'options': options, 'correctIndex': correctIndex};
  }
}
