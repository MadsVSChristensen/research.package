part of research_package_model;

class RPTappingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPTappingActivity(String identifier,
      {includeInstructions = true, includeResults = true, this.lengthOfTest = 5})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

    int lengthOfTest; //test length in seconds
}
