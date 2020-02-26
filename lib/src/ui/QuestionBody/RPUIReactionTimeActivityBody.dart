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
  int wrongTaps = 0;
  int correctTaps = 0;
  int timer = 0;
  int interval =
      4; //max interval between screen changes minus 1. (interval = 4 means color change happens in 1 to 5 seconds)
  int testDuration = 5; //test duration in seconds - time untill window changes
  final _random = new Random();
  DateTime time;
  bool lightOn = false;
  bool testLive = false;
  final _sw = new Stopwatch();
  List<int> rtList = [];
  double result = 0;
  bool readyToProceed = false;

  //wrong taps currently do nothing.

  void lightRegulator() {
    timer = _random.nextInt(interval) + 1;
    Timer(Duration(seconds: timer), () {
      setState(() {
        lightOn = true;
        _sw.start();
      });
    });
  }

  @override
  initState() {
    super.initState();
    time = DateTime.now();
    testLive = true;
    lightRegulator();
    Timer(Duration(seconds: testDuration), () {
      setState(() {
        if (rtList.isEmpty) {
          rtList.add(0);
        }
        for (int i = 0; i < rtList.length; i++) {
          result += (rtList[i]);
          print(rtList[i]);
        }
        result = result / rtList.length;
        widget.onResultChange(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (DateTime.now().difference(time).inSeconds < testDuration) {
      return Expanded(
          child: InkWell(
              onTap: () {
                if (lightOn) {
                  setState(() {
                    lightOn = false;
                    correctTaps++;
                    _sw.stop();
                    rtList.add(_sw.elapsedMilliseconds);
                    _sw.reset();
                  });
                  lightRegulator();
                } else {
                  wrongTaps++;
                  //penalty for wrong taps. WrongTaps are not actually used
                  rtList.add(1000);
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
