part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPTappingAnswerFormat extends RPAnswerFormat {
  RPTappingAnswerFormat();

  RPTappingAnswerFormat.withParams();

  factory RPTappingAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPTappingAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPTappingAnswerFormatToJson(this);
}
