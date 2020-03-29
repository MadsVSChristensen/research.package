part of research_package_model;

class RPLetterTappingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPLetterTappingActivity(String identifier,
      {includeInstructions, includeResults})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}
