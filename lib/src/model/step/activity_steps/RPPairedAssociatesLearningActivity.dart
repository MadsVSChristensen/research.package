part of research_package_model;

class RPPairedAssociatesLearningActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPPairedAssociatesLearningActivity(String identifier,
      {includeInstructions, includeResults})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}