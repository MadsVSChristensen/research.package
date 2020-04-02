part of research_package_ui;

class RPActivityGestureController {
  final RPActivityResult result;

  RPActivityGestureController(this.result);

  void addNewGesture() {}

  void testStarted() {
    result.stepTimes.addEntries([MapEntry('Test started', DateTime.now())]);
  }

  void testShown() {
    result.stepTimes.addEntries([MapEntry('Test shown', DateTime.now())]);
  }

  void testEnded() {
    result.stepTimes.addEntries([MapEntry('Test ended', DateTime.now())]);
  }

  void instructionStarted() {
    result.stepTimes
        .addEntries([MapEntry('Instruction started', DateTime.now())]);
  }

  void instructionEnded() {
    result.stepTimes
        .addEntries([MapEntry('Instruction ended', DateTime.now())]);
  }

  void resultsShown() {
    result.stepTimes.addEntries([MapEntry('results shown', DateTime.now())]);
  }

  void resultsClosed() {
    result.stepTimes.addEntries([MapEntry('results closed', DateTime.now())]);
  }

  void addCorrectGesture(String type, String description) {
    result.interactionTimes.addEntries([
      MapEntry(
          'Correct gesture',
          Map.fromEntries(
              [MapEntry('type', type), MapEntry('description', description)]))
    ]);
  }

  void addWrongGesture(String type, String description) {
    result.interactionTimes.addEntries([
      MapEntry(
          'Wrong gesture',
          Map.fromEntries(
              [MapEntry('type', type), MapEntry('description', description)]))
    ]);
  }
}
