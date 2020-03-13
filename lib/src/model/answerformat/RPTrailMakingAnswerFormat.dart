part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPTrailMakingAnswerFormat extends RPAnswerFormat {
  RPTrailMakingAnswerFormat();

  RPTrailMakingAnswerFormat.withParams();

  factory RPTrailMakingAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPTrailMakingAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPTrailMakingAnswerFormatToJson(this);
}
