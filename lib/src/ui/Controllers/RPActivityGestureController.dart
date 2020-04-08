part of research_package_ui;

class RPActivityGestureController {
  final RPActivityResult result;

  RPActivityGestureController(this.result);

  void addNewGesture() {}

  void testStarted() {
    result.stepTimes['test_started'] = DateTime.now();
  }

  void testShown() {
    result.stepTimes['test_shown'] = DateTime.now();
  }

  void testEnded() {
    result.stepTimes['test_ended'] = DateTime.now();
  }

  void instructionStarted() {
    result.stepTimes['instruction_started'] = DateTime.now();
  }

  void instructionEnded() {
    result.stepTimes['instruction_ended'] = DateTime.now();
  }

  void resultsShown() {
    result.stepTimes['results_shown'] = DateTime.now();
  }

  void resultsClosed() {
    result.stepTimes['results_closed'] = DateTime.now();
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
