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
  int interval = 3;
  int testDuration = 20; //test duration in seconds - time untill window changes
  int newNum = 0;
  int goodTaps = 0;
  int badTaps = 0;
  Duration displayTime = new Duration(seconds: 1);
  DateTime time;
  bool testLive = false;
  bool seqPassed = false;
  List<bool> listIndexes = [
    true
  ]; //booleans for keeping track of lowest index - for registering a sequence has passed
  List<int> seq1 = [1, 2, 3];
  List<int> curSeq = [];
  List<int> delaysList = [];
  final _sw = new Stopwatch();

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
      _sw.start(); //timer to note delay on presssing button after seeing sequence
      for (int i = 0; i < listIndexes.length-1; i++) {
        listIndexes[i + 1] = false;
      }
      print("true");
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
              //update this widget alone!!!!!
            ],
          ),
          OutlineButton(onPressed: () {
            if (seqPassed) {
              seqPassed = false;
              goodTaps++;
              print('good taps $goodTaps');
              _sw.stop();
              delaysList.add(_sw.elapsedMilliseconds);
              _sw.reset();
            } else {
              print('that was a bad tap');
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
