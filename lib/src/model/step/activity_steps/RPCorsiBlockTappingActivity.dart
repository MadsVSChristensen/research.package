part of research_package_model;

class RPCorsiBlockTappingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPCorsiBlockTappingActivity(String identifier,
      {includeInstructions, includeResults})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}
