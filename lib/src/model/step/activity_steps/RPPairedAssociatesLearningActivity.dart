part of research_package_model;

class RPPairedAssociatesLearningActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPPairedAssociatesLearningActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.maxTestDuration = 100})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  int maxTestDuration; //stop test after a given time.
}
