part of research_package_model;

class RPTappingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPTappingActivity(String identifier, {includeInstructions, includeResults})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}
