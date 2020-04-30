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
  int testDuration = 10;
  String countdown = '';
  bool setStart = false;
  bool indexStart = false;
  bool counting = true;
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
                'After a 3 second countdown, which will appear on screen, tap the two buttons as many times as possible, in 30 serconds.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
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
                        image: AssetImage(
                            'packages/research_package/assets/images/Tappingintro.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onPressed: () async {
                  setState(() {
                    activityStatus = ActivityStatus.Task;
                  });
                  widget.gestureLogger.instructionEnded();
                  widget.gestureLogger.testStarted();
                  for (int i = 3; i > 0; i--) {
                    if (this.mounted) {
                      setState(() {
                        countdown = i.toString();
                      });
                    }
                    await Future.delayed(Duration(seconds: 1));
                  }
                  if (this.mounted) {
                    //remove countdown text
                    setState(() {
                      counting =
                          false; 
                    });
                  }
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
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      case ActivityStatus.Task:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            counting
                ? Text(countdown, style: TextStyle(fontSize: 30))
                  :
            Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: OutlineButton(
                            onPressed: () {
                              widget.gestureLogger.addCorrectGesture(
                                  'Button tap', 'Pressed the left button');
                              setState(() {
                                taps++;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: OutlineButton(
                            onPressed: () {
                              widget.gestureLogger.addCorrectGesture(
                                  'Button tap', 'Pressed the right button');
                              setState(() {
                                taps++;
                              });
                            },
                          ),
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
          child: Text(
            '$taps was your final score!',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        );
    }
  }
}
