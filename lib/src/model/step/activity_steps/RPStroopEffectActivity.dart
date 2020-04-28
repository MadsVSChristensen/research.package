part of research_package_model;

class RPStroopEffectActivity extends RPActivityStep {
  /// Contructor for creating a Corsi Block Tapping Test.
  RPStroopEffectActivity(String identifier,
      {includeInstructions = true, includeResults = true})
      : super(identifier,
            includeInstructions: includeInstructions,
            includeResults: includeResults);
}
