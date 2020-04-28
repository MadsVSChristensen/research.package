part of research_package_model;

class RPRapidVisualInfoProcessingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPRapidVisualInfoProcessingActivity(String identifier,
      {includeInstructions = true, includeResults = true})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}
