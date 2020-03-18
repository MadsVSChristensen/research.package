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
  int testDuration = 20; //test duration in seconds - time untill window changes
  final _random = new Random();
  int displayTime =
      1500; //amount of time each word is displayed in milliseconds
  int delayTime = 1000; //amount of time between words
  Timer t = new Timer(Duration(seconds: 0),
      () {}); //construct for further control of timer. Cancel at window collapse.
  Timer pulseTimer =
      new Timer(Duration(seconds: 0), () {}); //pulse timer control
  bool testLive = false; //test going on, screen flag
  bool testBegin = true; //pre test screen flag
  bool disableButton = false; //makes sure spamming doesn't disturb the test
  List<String> possColorsString = [
    'BLUE',
    'GREEN',
    'RED',
    'YELLOW'
  ]; //the two lists are ordered, like in a map.
  //map is not used due to unwanted complexity
  List<Color> possColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow
  ];
  String cWord = '';
  Color wColor = Colors.white;

  @override
  initState() {
    super.initState();
    cWord = possColorsString[_random.nextInt(possColorsString.length)];
    wColor = possColors[_random.nextInt(possColors.length)];
  }

  void testControl() async {
    if (this.mounted) {
      setState(() {
        //change screen
        testBegin = false;
        testLive = true;
      });
    }
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      testLive = false;
      if (this.mounted) {
        setState(() {});
        widget.onResultChange(0);
      }
    });
    wordPulse();
  }

  void wordPulse() async {
    //control pulsation of words and pause between them
    disableButton = true;
    pulseTimer.cancel();
    if (this.mounted) {
      //make sure window is mounted and that test is live before setting state.
      if (testLive) {
        setState(() {
          cWord = '----';
          wColor = Colors.black;
        });
        await Future.delayed(
            Duration(milliseconds: delayTime)); //delay before showing next word
        if (this.mounted){
        setState(() {
          cWord = possColorsString[_random.nextInt(
              possColorsString.length)]; //pick word and color for display
          wColor = possColors[_random.nextInt(possColors.length)];
        });
        }
        disableButton = false;
      }
    }
    pulseTimer = Timer(Duration(milliseconds: displayTime), () {
      if (testLive) {
        wordPulse();
      }
    }); //call wordPulse recursively for periodic timer effect
  }

  @override
  Widget build(BuildContext context) {
    if (testBegin) {
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
                    'Tap the name of the color, of the word you see on screen.',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'E.g. tap the box that says "yellow" when a yellow word appears',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                  OutlineButton(onPressed: () {
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
    } else if (testLive) {
      //main screen for test - contains word and buttons to push
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 200,
                    child: Text(
                      cWord,
                      style: TextStyle(fontSize: 45, color: wColor),
                      textAlign: TextAlign.center,
                    ),
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _makeButton(0),
                  _makeButton(1),
                  _makeButton(2),
                  _makeButton(3),
                ])
          ]);
    } else {
      return Container(
          //result screen
          padding: EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'The test is done!',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Correct answers: $correctTaps',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Wrong answers: $wrongTaps',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ]));
    }
  }

  Widget _makeButton(int buttonNum) {
    //make material buttons for possible colors
    String buttonCode = possColorsString[buttonNum];
    return (Container(
        height: 40,
        width: 80,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5),
              side: BorderSide(color: Colors.black, width: 3)),
          onPressed: () {
            if (!disableButton) {
              if (wColor == possColors[buttonNum]) {
                //if a button was pressed, produce new word
                correctTaps++;
                wordPulse();
              } else {
                wrongTaps++;
                wordPulse();
              }
            }
          },
          child: Text('$buttonCode', style: TextStyle(fontSize: 12)),
        )));
  }
}
