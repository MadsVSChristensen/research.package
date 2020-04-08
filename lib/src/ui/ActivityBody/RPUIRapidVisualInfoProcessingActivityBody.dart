part of research_package_ui;

class RPUIRapidVisualInfoProcessingActivityBody extends StatefulWidget {
  final RPRapidVisualInfoProcessingActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityGestureController gestureController;

  RPUIRapidVisualInfoProcessingActivityBody(
      this.activity, this.gestureController, this.onResultChange);

  @override
  _RPUIRapidVisualInfoProcessingActivityBody createState() =>
      _RPUIRapidVisualInfoProcessingActivityBody();
}

class _RPUIRapidVisualInfoProcessingActivityBody
    extends State<RPUIRapidVisualInfoProcessingActivityBody> {
  final _random = new Random();
  String texthint =
      'A sequence will be shown on screen, along with a changing number. Whenever the whole sequence has passed (does not have to be right after each other), tap the button. E.g. if the sequence is 3-6-9, a valid press of the button is 3-4-1-6-9. They must be ordered but need not be in succession. ';
  int interval = 7; //interval in which numbers appear (should be 9 (0-9))
  int testDuration = 5; //test duration in seconds - time untill window changes
  int newNum = 0; //int for next random generated number on screen
  int goodTaps = 0; //number of taps that were correct
  int badTaps = 0; //number of taps that were wrong
  int seqsPassed =
      0; //number of times the given sequence passed: cap for good taps
  Duration displayTime =
      new Duration(seconds: 1); //amount of time each number is displayed
  ActivityStatus activityStatus;
  bool seqPassed =
      false; //if a sequence has passed or not, meaning a tap would be a correct tap if true
  List<bool> listIndexes = [
    true
  ]; //booleans for keeping track of lowest index - for registering a sequence has passed
  List<int> seq1 = [1, 4, 7]; //sequence of numbers that we wish to track
  List<int> curSeq = []; //numbers that have appeared on screen in a list
  List<int> delaysList =
      []; //list of delay from seqPassed is set true, to button is pressed
  final _sw = new Stopwatch();

  //Todo: determine how test results are evaluated: Hit sequences, delay in doing so, and false taps are recorded
  //seqsPassed can be different that good and bad taps total! Meaning tap should have occured but didnt, before next full sequence.

  @override
  initState() {
    super.initState();
    widget.gestureController.instructionStarted();
    activityStatus =
        ActivityStatus.Instruction; 
    for (int i = 0; i < seq1.length; i++) {
      //adds bools according to sequence lengths
      listIndexes.add(false);
    }
  }

  void timerBody() {
    Timer.periodic(
        //periodic timer to update number on screen - starts in init currently.
        displayTime, (Timer t) {
      //make sure window is mounted and that test is live before setting state.
      if (activityStatus == ActivityStatus.Task && this.mounted) {
        setState(() {
          numGenerator();
          sequenceChecker(
              seq1); //check for sequence - could be for looped through multiple sequences if wanted, displayng current one.
        });
      } else {
        t.cancel();
      }
    });
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      activityStatus = ActivityStatus.Result;
      if (this.mounted) {
        widget.gestureController.testEnded();
        widget.gestureController.resultsShown();
        widget.onResultChange(goodTaps);
      }
    });
  }

  void numGenerator() {
    //generates the numbers to display on screen
    int nextNum = _random.nextInt(interval) + 1; //plus one to not get 0.
    while (newNum == nextNum) {
      //currently code enforces no repetition of numbers - for graphics sakes.
      nextNum = _random.nextInt(interval) + 1;
    }
    newNum = nextNum;
    curSeq.add(newNum);
  }

//check if sequence have appeared through setting an array of bools for each number
//Keeping it dynamic, so size of sequence can vary freely
  void sequenceChecker(seq) {
    for (int i = 0; i < seq1.length; i++) {
      if (newNum == seq[i] && listIndexes[i] == true) {
        listIndexes[i + 1] = true;
      }
    }
    if (listIndexes[listIndexes.length - 1] == true) {
      //set all bool flags to false except first one, to restart sequencing
      seqPassed =
          true; //set flag so next press on button gives a positive result
      seqsPassed++;
      _sw.reset(); //if a new sequence passes, reset stopwatch
      _sw.start(); //timer to note delay on presssing button after seeing sequence
      for (int i = 0; i < listIndexes.length - 1; i++) {
        //reset list of bools for tracking if sequence passed
        listIndexes[i + 1] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          //entry screen with rules and start button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '$texthint',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
              onPressed: () {
                widget.gestureController.instructionEnded();
                widget.gestureController.testStarted();
                activityStatus = ActivityStatus.Task;
                timerBody();
              },
              child: Text('Ready'),
            ),
          ],
        );
      case ActivityStatus.Task:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$seq1', style: TextStyle(fontSize: 18)),
                  Container(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('$newNum', style: TextStyle(fontSize: 30)),
                    ],
                  ),
                  OutlineButton(onPressed: () {
                    //on pressed - time is tracked if sequence has actually passed, otherwise no
                    if (seqPassed) {
                      seqPassed = false;
                      goodTaps++;
                      _sw.stop();
                      delaysList.add(_sw.elapsedMilliseconds);
                      _sw.reset();
                    } else {
                      badTaps++;
                    }
                  })
                ],
              ))
            ]);
      case ActivityStatus.Result:
        return Container(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('The test is done!', style: TextStyle(fontSize: 22)),
                  Text(
                    'You had $goodTaps correct taps and $badTaps wrong ones',
                    style: TextStyle(fontSize: 20),
                  )
                ]));
    }
  }
}
