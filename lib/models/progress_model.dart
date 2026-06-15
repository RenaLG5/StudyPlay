class ProgressModel {
  int mathLevel;
  int languageLevel;
  int scienceLevel;
  int historyLevel;

  ProgressModel({
    required this.mathLevel,
    required this.languageLevel,
    required this.scienceLevel,
    required this.historyLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      "mathLevel": mathLevel,
      "languageLevel": languageLevel,
      "scienceLevel": scienceLevel,
      "historyLevel": historyLevel,
    };
  }

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      mathLevel: json["mathLevel"] ?? 1,
      languageLevel: json["languageLevel"] ?? 1,
      scienceLevel: json["scienceLevel"] ?? 1,
      historyLevel: json["historyLevel"] ?? 1,
    );
  }
}
