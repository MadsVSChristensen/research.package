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

  @override
  initState() {
    super.initState();
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    print(time.difference(DateTime.now()).inSeconds);
    return (DateTime.now().difference(time).inSeconds < 30)
        ? Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Text(
                  'Tap us with index and middle finger as fast as you can for 30 seconds!',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '$taps',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: <Widget>[
                    OutlineButton(
                      onPressed: () {
                        setState(() {
                          taps++;
                          print('tapped');
                        });
                      },
                    ),
                    OutlineButton(
                      onPressed: () {
                        setState(() {
                          taps++;
                          print('tapped2');
                        });
                      },
                    ),
                  ],
                )
              ],
            ))
        : Container(
            child: Text('$taps was your final score!'),
          );
  }
}
