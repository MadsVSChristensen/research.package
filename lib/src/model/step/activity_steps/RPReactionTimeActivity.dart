part of research_package_model;

class RPReactionTimeActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPReactionTimeActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.lengthOfTest = 5,
      this.switchInterval = 4})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  int lengthOfTest;

  /// How long the test should continue.
  int switchInterval;

  /// max seconds for light switch -1. Writing 4, means at most 5 seconds.
}
