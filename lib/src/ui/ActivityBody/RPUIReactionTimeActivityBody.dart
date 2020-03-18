part of research_package_ui;

class RPUIReactionTimeActivityBody extends StatefulWidget {
  final RPReactionTimeAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUIReactionTimeActivityBody(this.answerFormat, this.onResultChange);

  @override
  _RPUIReactionTimeActivityBodyState createState() =>
      _RPUIReactionTimeActivityBodyState();
}

class _RPUIReactionTimeActivityBodyState
    extends State<RPUIReactionTimeActivityBody> {
  String texthint = 'Tap the screen to start';
  int wrongTaps = 0;
  int correctTaps = 0;
  int timer = 0;
  int interval =
      4; //max interval between screen changes minus 1. (interval = 4 means color change happens in 1 to 5 seconds)
  int testDuration = 10; //test duration in seconds - time untill window changes
  final _random = new Random();
  DateTime time;
  bool lightOn = false; //If light is on, screen is green and should be tapped.
  bool testLive = false;
  bool first =
      true; //flag for extra time - so test doesn't just start right away
  final _sw = new Stopwatch();
  List<int> rtList = []; //delay times list
  double result = 0;
  //wrong taps currently do nothing.

  @override
  initState() {
    super.initState();
    testLive = true;
  }

  void lightRegulator() {
    //determines when light is changed, and starts timer when screen turns green. only called when light is red.
    timer = _random.nextInt(interval) + 1;
    Timer(Duration(seconds: timer), () {
      if (this.mounted) {
        setState(() {
          lightOn = true;
          _sw.start();
        });
      }
    });
  }

  void testTimer() {
    //times the test and calculates result when done.
    Timer(Duration(seconds: testDuration), () {
      testLive = false;
      if (this.mounted) {
        if (rtList.isEmpty) {
          //if nothing was pressed during the whole test, add 0.
          rtList.add(0);
        }
        for (int i = 0; i < rtList.length; i++) {
          result += (rtList[i]);
        }
        result = result / rtList.length; //calculate average delay from test.
        if (this.mounted) {
          widget.onResultChange(result);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (DateTime.now().difference(time).inSeconds < testDuration) {
      return Expanded(
          child: InkWell(
              onTap: () {
                if (first) {
                  first = false;
                  setState(() {
                    texthint = ''; //remove text hint when test starts.
                  });
                  testTimer();
                  lightRegulator();
                } else {
                  //on tap depends on if light is on. If so, record time, turn light off, and call lightRegulator.
                  if (lightOn) {
                    setState(() {
                      lightOn = false;
                      correctTaps++;
                      _sw.stop();
                      rtList.add(
                          _sw.elapsedMilliseconds); //add delay for current tap.
                      _sw.reset();
                    });
                    lightRegulator();
                  } else {
                    wrongTaps++;
                    //penalty for wrong taps. WrongTaps are not actually used
                    rtList.add(1000);
                  }
                }
              },
              child: Container(
                  color: lightOn ? Colors.green : Colors.red,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tap the screen when it turns green',
                        style: TextStyle(
                            fontSize: 22, color: Colors.white.withOpacity(1.0)),
                      ),
                      Text('$texthint',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ))));
    } else {
      return Container(
        padding: EdgeInsets.all(40),
        child: Text(
          'The time is up! $result was your final score. (Average reaction time in milliseconds)',
          style: TextStyle(fontSize: 22),
        ),
      );
    }
  }
}
