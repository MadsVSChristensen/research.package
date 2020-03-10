part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPReactionTimeAnswerFormat extends RPAnswerFormat {
  RPReactionTimeAnswerFormat();

  RPReactionTimeAnswerFormat.withParams();

  factory RPReactionTimeAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPReactionTimeAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPReactionTimeAnswerFormatToJson(this);
}
