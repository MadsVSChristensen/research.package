part of research_package_model;

/// Class representing an Answer Format that lets participants input a number (integer)
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPStroopEffectAnswerFormat extends RPAnswerFormat {
  RPStroopEffectAnswerFormat();

  RPStroopEffectAnswerFormat.withParams();

  factory RPStroopEffectAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$RPStroopEffectAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$RPStroopEffectAnswerFormatToJson(this);
}
