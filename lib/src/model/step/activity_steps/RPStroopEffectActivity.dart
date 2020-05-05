part of research_package_model;

class RPStroopEffectActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPStroopEffectActivity(String identifier,
      {includeInstructions = true,
      includeResults = true,
      this.lengthOfTest = 40,
      this.displayTime = 1000,
      this.delayTime = 750})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  int lengthOfTest; //test duration in seconds - time untill window changes
  int displayTime; //amount of time each word is displayed in milliseconds
  int delayTime; //amount of time between words in ms
}
