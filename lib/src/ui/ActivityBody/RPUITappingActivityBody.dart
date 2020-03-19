part of research_package_ui;

class RPUITappingActivityBody extends StatefulWidget {
  final RPTappingAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUITappingActivityBody(this.answerFormat, this.onResultChange);

  @override
  _RPUITappingActivityBodyState createState() =>
      _RPUITappingActivityBodyState();
}

class _RPUITappingActivityBodyState extends State<RPUITappingActivityBody> {
  int taps = 0;
  DateTime time;
  int testDuration = 30;
  bool testLive = true;

  @override
  initState() {
    super.initState();
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      testLive = false;
      if (this.mounted) {
        setState(() {});
        widget.onResultChange(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (testLive)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Tap us with index and middle finger as fast as you can for 30 seconds!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
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
          )
        : Container(
          alignment: Alignment.center,
            child: Text('$taps was your final score!'),
          );
  }
}
