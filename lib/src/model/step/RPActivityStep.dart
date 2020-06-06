part of research_package_model;

/// The concrete subclass of [RPStep] that represents a step in which a single Activity is presented to the user.
///
/// When a Task Widget presents an Activity Step object, it instantiates an [RPUIActivityStep] object to present the step.
/// The actual visual presentation depends on the type of RPActivity (e.g. [RPTrailMakingActivity]).
/// When you need to present more than one Activity at the same time, it can be appropriate to use [RPFormStep] instead of [RPActivityStep].
class RPActivityStep extends RPStep {
  /// Boolean controlling whether to show the intruction before the test.
  /// You may include your own [RPInstructionStep] before, if you wish to display other instructions.
  bool includeInstructions;

  /// Boolean controlling whether to show the results after the test.
  bool includeResults;

  /// The basic constructor which returns a Activity Step.
  /// The identifier is required for ID purposes.
  /// The optional parameters can be used exclude the non-test sections of the step.
  RPActivityStep(String identifier,
      {this.includeInstructions = true, this.includeResults = true})
      : super(identifier);

  /// The widget (UI representation) of the step.
  ///
  /// This gets initialized when a Activity Step has been added to a Task which is later presented by an [RPUITask] widget.
  @override
  Widget get stepWidget => RPUIActivityStep(this);
}

/// The possible stages each test can consist of
enum ActivityStatus { Instruction, Task, Result }
