part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPLetterTappingAnswerFormat extends RPAnswerFormat {
  RPLetterTappingAnswerFormat();

  RPLetterTappingAnswerFormat.withParams();

  factory RPLetterTappingAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPLetterTappingAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPLetterTappingAnswerFormatToJson(this);
}
