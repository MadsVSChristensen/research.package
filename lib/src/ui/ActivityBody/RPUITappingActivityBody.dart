part of research_package_ui;

class RPUITappingActivityBody extends StatefulWidget {
  final RPTappingActivity activity;
  final Function(dynamic) onResultChange;
  //final RPActivityGestureController gestureController;

  RPUITappingActivityBody(this.activity, this.onResultChange);
  //this.gestureController,

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
    activityStatus = ActivityStatus.Instruction;
    //widget.gestureController.instructionStarted();
  }

  void testControl() {
    if (this.mounted) {
      setState(() {});
      activityStatus = ActivityStatus.Task;
    }
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      activityStatus = ActivityStatus.Result;
      //widget.gestureController.testEnded();
      //widget.gestureController.resultsShown();
      if (this.mounted) {
        setState(() {});
        widget.onResultChange({"Total taps": taps});
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
                'Tap the two buttons as many times as possible, in 30 serconds. Use alternating taps with middle and index finger. Start with whichever finger you prefer.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
                onPressed: () {
                  activityStatus = ActivityStatus.Task;
                  //widget.gestureController.instructionEnded();
                  //widget.gestureController.testStarted();
                  testControl();
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
                        Container(
                          width: 140,
                          height: 100,
                          child: OutlineButton(
                            onPressed: () {
                              taps++;
                              //widget.gestureController.addCorrectGesture(
                              //    'Button tap', 'Pressed the left button');
                              //alternating taps code underneath
                                /* if (!setStart) {
                                  setStart = true;
                                  indexStart = true;         
                                  taps++;
                                }
                                if (indexStart && (taps % 2 == 0)) {
                                  taps++;
                                } else if (!indexStart && !(taps % 2 == 0)) {
                                  taps++;
                                } */
                            },
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 100,
                          child: OutlineButton(
                            onPressed: () {
                              taps++;
                              //widget.gestureController.addCorrectGesture(
                              //    'Button tap', 'Pressed the right button');
                              //alternating taps code underneath
                                /* if (!setStart) {
                                  setStart = true;           
                                }
                                if (indexStart && (taps % 2 != 0)) {
                                  taps++;
                                } else if (!indexStart && (taps % 2 == 0)) {
                                  taps++;
                                } */
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
          child: Text('$taps was your final score!'),
        );
    }
  }
}
