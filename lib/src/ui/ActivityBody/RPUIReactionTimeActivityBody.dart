part of research_package_ui;

class RPUIReactionTimeActivityBody extends StatefulWidget {
  final RPReactionTimeActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityGestureController gestureController;

  RPUIReactionTimeActivityBody(
      this.activity, this.gestureController, this.onResultChange);

  @override
  _RPUIReactionTimeActivityBodyState createState() =>
      _RPUIReactionTimeActivityBodyState();
}

class _RPUIReactionTimeActivityBodyState
    extends State<RPUIReactionTimeActivityBody> {
  ActivityStatus activityStatus;
  String alert = '';
  int wrongTaps = 0;
  int correctTaps = 0;
  int timer = 0;
  int interval =
      4; //max interval between screen changes minus 1. (interval = 4 means color change happens in 1 to 5 seconds)
  int testDuration = 5; //test duration in seconds - time untill window changes
  final _random = Random();
  bool lightOn = false; //If light is on, screen is green and should be tapped.
  bool allowGreen = true;
  bool first = true;
  final _sw = Stopwatch();
  List<int> rtList = []; //delay times list
  int result = 0;
  Timer lightTimer;
  //wrong taps currently do nothing.

  @override
  initState() {
    super.initState();
    activityStatus = ActivityStatus.Instruction;
  }

  void lightRegulator() {
    if (!first) {
      lightTimer.cancel();
    }
    //determines when light is changed, and starts timer when screen turns green. only called when light is red.
    timer = _random.nextInt(interval) + 1;
    lightTimer = Timer(Duration(seconds: timer), () {
      if (this.mounted && allowGreen) {
        setState(() {
          alert = ''; //"too quick alert set to nothing when light is green"
          lightOn = true; //turn on green light
          _sw.start(); //start stopwatch to track delay from green screen till tap.
        });
      }
    });
    first = false;
  }

  void testTimer() {
    //times the test and calculates result when done.
    Timer(Duration(seconds: testDuration), () {
      activityStatus = ActivityStatus.Result;
      if (this.mounted) {
        if (rtList.isEmpty) {
          //if nothing was pressed during the whole test, add 0.
          rtList.add(0);
        }
        for (int i = 0; i < rtList.length; i++) {
          result += (rtList[i]);
        }
        result = (result / rtList.length)
            .round(); //calculate average delay from test.
        if (this.mounted) {
          widget.onResultChange({
            "avg. reaction time": result,
            "Wrong taps": wrongTaps,
            "Correct taps": correctTaps
          });
        }
      }
    });
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
                'Tap the screen every time it turns from red to green, as fast as possible',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Reactionintro.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onPressed: () {
                  if (this.mounted) {
                    setState(() {
                      activityStatus = ActivityStatus.Task;
                    });
                  }
                  testTimer();
                  lightRegulator();
                },
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      case ActivityStatus.Task:
        return Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  child: InkWell(
                      onTap: () async {
                        //on tap depends on if light is on. If so, record time, turn light off, and call lightRegulator.
                        if (lightOn) {
                          setState(() {
                            lightOn = false;
                            correctTaps++;
                            _sw.stop();
                            rtList.add(_sw
                                .elapsedMilliseconds); //add delay for current tap.
                            _sw.reset();
                          });
                          lightRegulator();
                        } else {
                          allowGreen = false;
                          wrongTaps++;
                          setState(() {
                            alert = 'Too quick';
                          });
                          await Future.delayed(
                              Duration(seconds: 1)); //display feedback
                          if (this.mounted) {
                            allowGreen = true;
                            setState(() {
                              alert = '';
                            });
                            lightRegulator();
                          } //no actual penalty for wrong taps (would give a wrong picture). WrongTaps are not actually used
                        }
                      },
                      child: Container(
                          color: lightOn ? Colors.green : Colors.red,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                alert,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white.withOpacity(1.0)),
                              ),
                            ],
                          ))))
            ]);
      case ActivityStatus.Result:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40),
              child: Text(
                'The time is up! $result was your final score. (Average reaction time in milliseconds)',
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        );
    }
  }
}
