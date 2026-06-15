class GameResult {
  final String date;
  final String timeSpent;
  final bool isVictory;
  final String difficulty;

  final String subject;
  final int correctAnswers;
  final int wrongAnswers;

  final int level;

  GameResult({
    required this.date,
    required this.timeSpent,
    required this.isVictory,
    required this.difficulty,
    required this.subject,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "timeSpent": timeSpent,
      "isVictory": isVictory,
      "difficulty": difficulty,
      "subject": subject,
      "correctAnswers": correctAnswers,
      "wrongAnswers": wrongAnswers,
      "level": level,
    };
  }

  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      date: json["date"],
      timeSpent: json["timeSpent"],
      isVictory: json["isVictory"],
      difficulty: json["difficulty"],
      subject: json["subject"],
      correctAnswers: json["correctAnswers"],
      wrongAnswers: json["wrongAnswers"],
      level: json["level"],
    );
  }
}
