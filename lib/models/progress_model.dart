class ProgressModel {
  int mathLevel;
  int languageLevel;
  int scienceLevel;
  int historyLevel;

  bool mathCompleted;
  bool languageCompleted;
  bool scienceCompleted;
  bool historyCompleted;

  ProgressModel({
    required this.mathLevel,
    required this.languageLevel,
    required this.scienceLevel,
    required this.historyLevel,
    required this.mathCompleted,
    required this.languageCompleted,
    required this.scienceCompleted,
    required this.historyCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      "mathLevel": mathLevel,
      "languageLevel": languageLevel,
      "scienceLevel": scienceLevel,
      "historyLevel": historyLevel,
      "mathCompleted": mathCompleted,
      "languageCompleted": languageCompleted,
      "scienceCompleted": scienceCompleted,
      "historyCompleted": historyCompleted,
    };
  }

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      mathLevel: json["mathLevel"] ?? 1,
      languageLevel: json["languageLevel"] ?? 1,
      scienceLevel: json["scienceLevel"] ?? 1,
      historyLevel: json["historyLevel"] ?? 1,
      mathCompleted: json["mathCompleted"] ?? false,
      languageCompleted: json["languageCompleted"] ?? false,
      scienceCompleted: json["scienceCompleted"] ?? false,
      historyCompleted: json["historyCompleted"] ?? false,
    );
  }
}
