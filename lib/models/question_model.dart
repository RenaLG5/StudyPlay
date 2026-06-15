class QuestionModel {
  final String titulo;
  final String min;
  final String max;
  int valor;

  QuestionModel({
    required this.titulo,
    required this.min,
    required this.max,
    this.valor = 0,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      titulo: json["titulo"],
      min: json["min"],
      max: json["max"],
      valor: json["valor"] ?? 0,
    );
  }
}
