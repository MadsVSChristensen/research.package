part of research_package_ui;

class RPUITappingActivityBody extends StatefulWidget {
  final RPTappingActivity activity;
  final Function(dynamic) onResultChange;

  RPUITappingActivityBody(this.activity, this.onResultChange);

  @override
  _RPUITappingActivityBodyState createState() =>
      _RPUITappingActivityBodyState();
}

class _RPUITappingActivityBodyState extends State<RPUITappingActivityBody> {
  int taps = 0;
  int testDuration = 30;
  ActivityStatus activityStatus;

  @override
  initState() {
    super.initState();
    activityStatus = ActivityStatus.Instruction;
  }

  void testControl() {
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      activityStatus = ActivityStatus.Result;
      if (this.mounted) {
        setState(() {});
        widget.onResultChange(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Row(
          //entry screen with rules and start button
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Tap us with index and middle finger as fast as you can for 30 seconds!',
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    OutlineButton(onPressed: () {
                      activityStatus = ActivityStatus.Task;
                      testControl();
                    }),
                    Text(
                      'Tap the button when ready.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            )
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
                    Text(
                      '$taps',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            setState(() {
                              taps++;
                            });
                          },
                        ),
                        OutlineButton(
                          onPressed: () {
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