part of research_package_ui;

class RPUIStroopEffectActivityBody extends StatefulWidget {
  final RPStroopEffectActivity activity;
  final Function(dynamic) onResultChange;

  RPUIStroopEffectActivityBody(this.activity, this.onResultChange);

  @override
  _RPUIStroopEffectActivityBodyState createState() =>
      _RPUIStroopEffectActivityBodyState();
}

class _RPUIStroopEffectActivityBodyState
    extends State<RPUIStroopEffectActivityBody> {
  int mistakes = 0;
  int correctTaps = 0;
  int testDuration = 5; //test duration in seconds - time untill window changes
  final _random = new Random();
  int displayTime =
      1250; //amount of time each word is displayed in milliseconds
  int delayTime = 750; //amount of time between words
  Timer t = new Timer(Duration(seconds: 0),
      () {}); //construct for further control of timer. Cancel at window collapse.
  Timer pulseTimer =
      new Timer(Duration(seconds: 0), () {}); //pulse timer control
  ActivityStatus activityStatus;
  //bool testLive = false; //test going on, screen flag
  //bool testBegin = true; //pre test screen flag
  bool disableButton = false; //makes sure spamming doesn't disturb the test
  bool clicked = false; //boolean to track if the user taps an answer in time
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
  List<Color> backgroundButtons = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  String cWord = '';
  Color wColor = Colors.white;

  @override
  initState() {
    super.initState();
    activityStatus = ActivityStatus.Instruction;
    cWord = possColorsString[_random.nextInt(possColorsString.length)];
    wColor = possColors[_random.nextInt(possColors.length)];
  }

  void testControl() {
    if (this.mounted) {
      setState(() {
        //change screen
        activityStatus = ActivityStatus.Task;
      });
    }
    Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      activityStatus = ActivityStatus.Result;
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
    //make sure window is mounted and that test is live before setting state.
    if (this.mounted && activityStatus == ActivityStatus.Task) {
      setState(() {
        cWord = '----';
        wColor = Colors.black;
      });
      await Future.delayed(
          Duration(milliseconds: delayTime)); //delay before showing next word
      backgroundButtons = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white
      ]; //reset feedback
      if (this.mounted && activityStatus == ActivityStatus.Task) {
        setState(() {
          cWord = possColorsString[_random.nextInt(possColorsString.length)];
          wColor = possColors[_random
              .nextInt(possColors.length)]; //pick word and color for display
        });
      }
      disableButton = false; //make buttons tap-able
    }

    pulseTimer = Timer(Duration(milliseconds: displayTime), () {
      if (activityStatus == ActivityStatus.Task) {
        if (!clicked) {
          //if tap doesnt happen in time, count is a mistake.
          mistakes++;
        } else {
          clicked = false;
        }
        wordPulse();
      }
    }); //call wordPulse recursively for periodic timer effect
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
    case ActivityStatus.Task:
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
    case ActivityStatus.Result:
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
                        'Wrong answers or missed words: $mistakes',
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
          color: backgroundButtons[
              buttonNum], //set background on buttons for feedback
          onPressed: () {
            if (!disableButton) {
              clicked = true;
              if (wColor == possColors[buttonNum]) {
                //if a button was pressed, produce new word
                correctTaps++;
                if (this.mounted && activityStatus == ActivityStatus.Task) {
                  setState(() {
                    backgroundButtons[buttonNum] =
                        Colors.green; //set feedback color
                  });
                }
                wordPulse();
              } else {
                mistakes++;
                if (this.mounted && activityStatus == ActivityStatus.Task) {
                  setState(() {
                    backgroundButtons[buttonNum] = Colors.red;
                  });
                }
                wordPulse();
              }
            }
          },
          child: Text('$buttonCode', style: TextStyle(fontSize: 12)),
        )));
  }
}
