part of research_package_ui;

class RPActivityGestureLogger {
  final RPActivityResult result;

  RPActivityGestureLogger(this.result);

  void testStarted() {
    result.stepTimes.testStarted = DateTime.now();
  }

  void testShown() {
    result.stepTimes.testShown = DateTime.now();
  }

  void testEnded() {
    result.stepTimes.testEnded = DateTime.now();
  }

  void instructionStarted() {
    result.stepTimes.instructionStarted = DateTime.now();
  }

  void instructionEnded() {
    result.stepTimes.instructionEnded = DateTime.now();
  }

  void resultsShown() {
    result.stepTimes.resultsShown = DateTime.now();
  }

  void resultsClosed() {
    result.stepTimes.resultsClosed = DateTime.now();
  }

  void addCorrectGesture(String type, String description) {
    result.interactions.add(Interaction.withData(
        DateTime.now(), 'Correct gesture', type, description));
  }

  void addWrongGesture(String type, String description) {
    result.interactions.add(Interaction.withData(
        DateTime.now(), 'Wrong gesture', type, description));
  }
}
