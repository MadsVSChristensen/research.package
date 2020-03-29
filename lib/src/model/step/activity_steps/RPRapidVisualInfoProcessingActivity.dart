part of research_package_model;

class RPRapidVisualInfoProcessingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPRapidVisualInfoProcessingActivity(String identifier,
      {includeInstructions, includeResults})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}
