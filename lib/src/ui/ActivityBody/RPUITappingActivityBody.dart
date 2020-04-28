part of research_package_ui;

class RPUITappingActivityBody extends StatefulWidget {
  final RPTappingActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityGestureLogger gestureLogger;

  RPUITappingActivityBody(
      this.activity, this.gestureLogger, this.onResultChange);

  @override
  _RPUITappingActivityBodyState createState() =>
      _RPUITappingActivityBodyState();
}

class _RPUITappingActivityBodyState extends State<RPUITappingActivityBody> {
  int taps = 0;
  int testDuration = 3;
  bool setStart = false;
  bool indexStart = false;
  ActivityStatus activityStatus;

  @override
  initState() {
    super.initState();
    if (widget.activity.includeInstructions) {
      activityStatus = ActivityStatus.Instruction;
      widget.gestureLogger.instructionStarted();
    } else {
      activityStatus = ActivityStatus.Task;
      widget.gestureLogger.instructionStarted();
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
                'Tap the two buttons as many times as possible, in 30 serconds. Use alternating taps with middle and index finger. Start with whichever finger you prefer.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
                onPressed: () {
                  setState(() {
                    activityStatus = ActivityStatus.Task;
                  });
                  widget.gestureLogger.instructionEnded();
                  widget.gestureLogger.testStarted();
                  Timer(Duration(seconds: testDuration), () {
                    //when time is up, change window and set result
                    widget.gestureLogger.testEnded();
                    widget.onResultChange({"Total taps": taps});
                    if (widget.activity.includeResults) {
                      widget.gestureLogger.resultsShown();
                      if (this.mounted) {
                        setState(() {
                          activityStatus = ActivityStatus.Result;
                        });
                      }
                    }
                  });
                },
                child: Text('Ready')),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Tappingintro.png'))),
              ),
            ),
          ],
        );
      case ActivityStatus.Task:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            widget.gestureLogger.addCorrectGesture(
                                'Button tap', 'Pressed the left button');
                            setState(() {
                              taps++;
                            });
                          },
                        ),
                        OutlineButton(
                          onPressed: () {
                            widget.gestureLogger.addCorrectGesture(
                                'Button tap', 'Pressed the right button');
                            setState(() {
                              taps++;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ))
          ],
        );
      case ActivityStatus.Result:
        return Container(
          alignment: Alignment.center,
          child: Text('$taps was your final score!'),
        );
    }
  }
}
