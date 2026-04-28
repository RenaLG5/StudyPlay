class GameResult {
  final String date;
  final String timeSpent;
  final bool isVictory;
  final String difficulty;

  final String subject;
  final int correctAnswers;
  final int wrongAnswers;

  GameResult({
    required this.date,
    required this.timeSpent,
    required this.isVictory,
    required this.difficulty,
    required this.subject,
    required this.correctAnswers,
    required this.wrongAnswers,
  });
}
