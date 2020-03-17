part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPCorsiBlockTappingAnswerFormat extends RPAnswerFormat {
  RPCorsiBlockTappingAnswerFormat();

  RPCorsiBlockTappingAnswerFormat.withParams();

  factory RPCorsiBlockTappingAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPCorsiBlockTappingAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RPCorsiBlockTappingAnswerFormatToJson(this);
}
