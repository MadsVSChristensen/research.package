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
    if (this.mounted) {
      setState(() {});
      activityStatus = ActivityStatus.Task;
    }
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
        return Column(
          //entry screen with rules and start button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Tap the two buttons which will appear on screen, with index and middle finger as fast as you can for 30 seconds',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
                onPressed: () {
                  activityStatus = ActivityStatus.Task;
                  testControl();
                },
                child: Text('Ready')),
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
