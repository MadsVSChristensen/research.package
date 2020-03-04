part of research_package_ui;

class RPUIRapidVisualInfoProcessingBody extends StatefulWidget {
  final RPRapidVisualInfoProcessingAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUIRapidVisualInfoProcessingBody(this.answerFormat, this.onResultChange);

  @override
  _RPUIRapidVisualInfoProcessingBody createState() =>
      _RPUIRapidVisualInfoProcessingBody();
}

class _RPUIRapidVisualInfoProcessingBody
    extends State<RPUIRapidVisualInfoProcessingBody> {
  final _random = new Random();
  int interval = 3; //interval in which numbers appear (should be 9 (0-9))
  int testDuration = 40; //test duration in seconds - time untill window changes
  int newNum = 0; //int for next random generated number on screen
  int goodTaps = 0; //number of taps that were correct
  int badTaps = 0; //number of taps that were wrong
  int seqsPassed =
      0; //number of times the given sequence passed: cap for good taps
  Duration displayTime =
      new Duration(seconds: 1); //amount of time each number is displayed
  DateTime time; //current time
  bool testLive = false; //whether the test is in progress or not
  bool seqPassed =
      false; //if a sequence has passed or not, meaning a tap would be a correct tap if true.
  List<bool> listIndexes = [
    true
  ]; //booleans for keeping track of lowest index - for registering a sequence has passed
  List<int> seq1 = [1, 2, 3]; //sequence of numbers that we wish to track
  List<int> curSeq = []; //numbers that have appeared on screen in a list
  List<int> delaysList =
      []; //list of delay from seqPassed is set true, to button is pressed.
  final _sw = new Stopwatch();

  //Todo: determine how test results are evaluated: Hit sequences, delay in doing so, and false taps are recorded.
  //seqsPassed can be different that good and bad taps total! Meaning tap should have occured but didnt, before next full sequence.

  @override
  initState() {
    numGenerator();
    super.initState();
    time = DateTime.now();
    testLive = true; //test currently starts right away
    new Timer.periodic(
        //periodic timer to update number on screen - starts in init currently.
        displayTime, (Timer t) {
      if (this.mounted) {
        //make sure window is mounted and that test is live before setting state.
        if (testLive) {
          setState(() {
            numGenerator();
            sequenceChecker(
                seq1); //check for sequence - could be for looped through multiple sequences if wanted, displayng current one.
          });
        } else {
          t.cancel();
        }
      }
    });
    for (int i = 0; i < seq1.length; i++) {
      //adds bools according to sequence lengths
      listIndexes.add(false);
    }
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      testLive = false;
      widget.onResultChange(0);
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
//Keeping it dynamic, so size of sequence can vary freely.
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
      _sw.reset(); //if a new sequence passes, reset stopwatch.
      _sw.start(); //timer to note delay on presssing button after seeing sequence
      for (int i = 0; i < listIndexes.length - 1; i++) {
        listIndexes[i + 1] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (testLive) {
      return Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Click the button when you see the sequence:',
              style: TextStyle(fontSize: 18)),
          Text('$seq1', style: TextStyle(fontSize: 18)),
          Container(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$newNum', style: TextStyle(fontSize: 30)),
            ],
          ),
          OutlineButton(onPressed: () {
            //on pressed - time is tracked if sequence has actually passed, otherwise no.
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
      ));
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          'bing bong youre done with $goodTaps good taps and $badTaps wrong taps',
          style: TextStyle(fontSize: 22),
        ),
      );
    }
  }
}
