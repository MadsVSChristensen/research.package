part of research_package_model;

class RPReactionTimeActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPReactionTimeActivity(String identifier,
      {includeInstructions, includeResults, this.lengthOfTest})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  /// How long the test should continue.
  int lengthOfTest;
}
