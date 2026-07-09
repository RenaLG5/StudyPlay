class GameResult {
  final String date;
  final String timeSpent;
  final bool isVictory;
  final String difficulty;
  final String subject;
  final int correctAnswers;
  final int wrongAnswers;
  final int level;
  final int course;

  GameResult({
    required this.date,
    required this.timeSpent,
    required this.isVictory,
    required this.difficulty,
    required this.subject,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.level,
    required this.course,
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
      "course": course,
    };
  }

  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      date: json["date"] ?? "",
      timeSpent: json["timeSpent"] ?? "",
      isVictory: json["isVictory"] ?? false,
      difficulty: json["difficulty"] ?? "",
      subject: json["subject"] ?? "",
      correctAnswers: json["correctAnswers"] ?? 0,
      wrongAnswers: json["wrongAnswers"] ?? 0,
      level: json["level"] ?? 1,
      course: json["course"] ?? 1,
    );
  }
}
