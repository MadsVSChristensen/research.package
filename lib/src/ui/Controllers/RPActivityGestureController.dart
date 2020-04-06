part of research_package_ui;

class RPActivityGestureController {
  final RPActivityResult result;

  RPActivityGestureController(this.result);

  void addNewGesture() {}

  void testStarted() {
    result.stepTimes['Test started'] = DateTime.now();
  }

  void testShown() {
    result.stepTimes['Test shown'] = DateTime.now();
  }

  void testEnded() {
    result.stepTimes['Test ended'] = DateTime.now();
  }

  void instructionStarted() {
    result.stepTimes['Instruction started'] = DateTime.now();
  }

  void instructionEnded() {
    result.stepTimes['Instruction ended'] = DateTime.now();
  }

  void resultsShown() {
    result.stepTimes['results shown'] = DateTime.now();
  }

  void resultsClosed() {
    result.stepTimes['results closed'] = DateTime.now();
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
