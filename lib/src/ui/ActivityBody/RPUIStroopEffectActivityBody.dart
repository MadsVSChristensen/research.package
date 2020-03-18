part of research_package_ui;

class RPUIStroopEffectActivityBody extends StatefulWidget {
  final RPStroopEffectAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUIStroopEffectActivityBody(this.answerFormat, this.onResultChange);

  @override
  _RPUIStroopEffectActivityBodyState createState() =>
      _RPUIStroopEffectActivityBodyState();
}

class _RPUIStroopEffectActivityBodyState
    extends State<RPUIStroopEffectActivityBody> {
  int wrongTaps = 0;
  int correctTaps = 0;
  int timer = 0;
  
  int testDuration = 5; //test duration in seconds - time untill window changes
  final _random = new Random();
  DateTime time;
  bool testLive = false;
  bool first =
      true; //flag for extra time - so test doesn't just start right away
  final _sw = new Stopwatch();

  @override
  initState() {
    super.initState();
    time = DateTime.now();
    testLive = true;
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      testLive = false;
      if (this.mounted) {
        widget.onResultChange(0);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    //if (testLive) {
      return Expanded(
          child: Text(
          'Welcome',
          style: TextStyle(fontSize: 22),
        ),);
    /* } else {
      return Container(
        padding: EdgeInsets.all(40),
        child: Text(
          'The time is up!',
          style: TextStyle(fontSize: 22),
        ),
      );
    } */
  }
}
