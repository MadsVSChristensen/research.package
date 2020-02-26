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
  int testDuration = 15; //test duration in seconds - time untill window changes
  final _random = new Random();
  DateTime time;
  bool lightOn = false;
  bool testLive = false;
  final _sw = new Stopwatch();
  List<int> rtList = [];
  double result = 0;

  //wrong taps currently do nothing.

  void lightRegulator() {
    timer = _random.nextInt(7) + 1;
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
        for (int i = 0; i < rtList.length; i++) {
          result += (rtList[i]);
          print(rtList[i]);
        }
        result = result / rtList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (DateTime.now().difference(time).inSeconds < testDuration)
        ? Container(
            padding: EdgeInsets.all(40),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  'Tap the button when the green light is on',
                  style: TextStyle(fontSize: 18),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 35,
                      width: 80,
                      color: lightOn ? Colors.green : Colors.red,
                    ),
                    OutlineButton(
                      onPressed: () {
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
                          //penalty for wrong taps. WrongTaps are not actually j
                          rtList.add(1000);
                        }
                      },
                    ),
                  ],
                )
              ],
            ))
        : Container(
            child: Text('The time is up! $result was your final score. (Average reaction time in milliseconds)'),
          );
  }
}
