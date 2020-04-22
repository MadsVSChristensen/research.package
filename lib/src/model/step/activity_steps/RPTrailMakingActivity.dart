part of research_package_model;

class RPTrailMakingActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPTrailMakingActivity(String identifier,
      {includeInstructions = true, includeResults = true, this.trailType})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);

  TrailType trailType;
}

enum TrailType { Letters, LettersAndNumbers }
