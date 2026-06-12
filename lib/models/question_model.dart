class QuestionModel {
  final int id;

  final String question;

  int answer;

  QuestionModel({required this.id, required this.question, this.answer = 0});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(id: json['id'], question: json['question']);
  }
}
