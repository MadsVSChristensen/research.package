part of research_package_model;

class RPRapidVisualInfoProcessingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPRapidVisualInfoProcessingActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.interval = 7,
      this.lengthOfTest = 5,
      this.sequence = const [1, 4, 7]})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  int interval; //interval in which numbers to display are picked (could be 9 (0-9))
  int lengthOfTest; //test duration in seconds - time untill window changes
  List<int> sequence; //sequence of numbers that we wish to track
}
