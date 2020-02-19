part of research_package_model;

/// The concrete subclass of [RPStep] that represents a step in which a single Activity is presented to the user.
///
/// When a Task Widget presents an Activity Step object, it instantiates an [RPUIActivityStep] object to present the step. The actual visual presentation depends on the answer format ([RPAnswerFormat]).
/// When you need to present more than one Activity at the same time, it can be appropriate to use [RPFormStep] instead of [RPActivityStep].
class RPActivityStep extends RPStep {
  RPAnswerFormat _answerFormat;
  String _placeholder;

  /// The basic constructor which returns a Activity Step with only the identifier filled out
  RPActivityStep(String identifier) : super(identifier);

  /// Returns a Activity Step populated with title (text of the Activity)
  RPActivityStep.withTitle(String identifier, String title)
      : super.withTitle(identifier, title);

  /// Returns a Activity Step populated with title (text of the Activity) and answer format on which the
  /// actual layout depends
  RPActivityStep.withAnswerFormat(
      String identifier, String title, this._answerFormat)
      : super.withTitle(identifier, title);

  /// The answer format which describes the format how a Activity can be answered.
  RPAnswerFormat get answerFormat => _answerFormat;

  /// The placeholder text for the Activity Steps using an answer format which requires text entry
  String get placeholder => _placeholder;

  set answerFormat(RPAnswerFormat answerFormat) {
    this._answerFormat = answerFormat;
  }

  set placeholder(String placeholder) {
    this._placeholder = placeholder;
  }

  /// The widget (UI representation) of the step.
  ///
  /// This gets initialized when a Activity Step has been added to a Task which is later presented by an [RPUIOrderedTask] widget.
  @override
  Widget get stepWidget => RPUIActivityStep(this);
}
