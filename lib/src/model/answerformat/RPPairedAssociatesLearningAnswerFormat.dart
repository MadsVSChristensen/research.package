part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPPairedAssociatesLearningAnswerFormat extends RPAnswerFormat {
  RPPairedAssociatesLearningAnswerFormat();

  RPPairedAssociatesLearningAnswerFormat.withParams();

  factory RPPairedAssociatesLearningAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPPairedAssociatesLearningAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPPairedAssociatesLearningAnswerFormatToJson(this);
}
