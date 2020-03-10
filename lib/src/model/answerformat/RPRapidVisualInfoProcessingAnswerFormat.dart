part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPRapidVisualInfoProcessingAnswerFormat extends RPAnswerFormat {
  RPRapidVisualInfoProcessingAnswerFormat();

  RPRapidVisualInfoProcessingAnswerFormat.withParams();

  factory RPRapidVisualInfoProcessingAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPRapidVisualInfoProcessingAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPRapidVisualInfoProcessingAnswerFormatToJson(this);
}
