part of research_package_ui;

class RPUIPairedAssociatesLearningBody extends StatefulWidget {
  final RPPairedAssociatesLearningAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUIPairedAssociatesLearningBody(this.answerFormat, this.onResultChange);

  @override
  _RPUIPairedAssociatesLearningBody createState() =>
      _RPUIPairedAssociatesLearningBody();
}

class _RPUIPairedAssociatesLearningBody
    extends State<RPUIPairedAssociatesLearningBody> {
  final _random = new Random();
  bool testBegin = true;
  bool testLive = false;
  bool buttonsDisabled = false;
  int correct =
      0; //introduce int that can be 0, 1 and 2 for three possibilities. (indicates if, and which icon to show)
  int successes = 0;
  int mistakes = 0;
  int testDuration = 20; //test duration in seconds - time untill window changes
  Timer t = new Timer(Duration(seconds: 0),
      () {}); //construct for further control of timer. Cancel at window collapse.
  List<Color> containers = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ]; //a container can be empty, default values, or have a shape identified by an int
  List<Color> containerHide = [
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green
  ];
  List<Color> shapes1 = [Colors.red]; //colors for inital logic setup
  List<Color> shapes2 = [Colors.red, Colors.blue];
  List<Color> shapes3 = [Colors.red, Colors.blue, Colors.yellow];
  List<Color> shapes4 = [Colors.red, Colors.blue, Colors.yellow, Colors.purple];
  List<List> levels = []; //list of all levels. Add in init.
  Color matchObject = Colors.transparent;

//feedback on clicking right or wrong... and shapessssss

  void testStarter() {
    //begin test by changing window and starting timer.
    setState(() {
      testBegin = false; //set flags to go to next screen
      testLive = true;
    });
    containerPeaker();
    t = Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      testLive = false;
      if (this.mounted) {
        widget.onResultChange(0);
      }
    });
  }

  void containerContent(level) {
    correct = 0; //set no feedback icon.
    //fill containers with content
    for (int i = 0; i < containers.length; i++) {
      //let all containers be green from start of levels.
      containers[i] = Colors.white;
    }
    matchObject =
        level[_random.nextInt(level.length)]; //fill object with content
    List<int> containing = []; //list of containers that already has content
    int chosenContainer =
        _random.nextInt(containers.length); //container to fill with content

    for (int i = 0; i < level.length; i++) {
      //for every possible shape, fill a container with it
      while (containing.contains(chosenContainer)) {
        //be sure not to fill same containers
        chosenContainer =
            _random.nextInt(containers.length); //choose random containers
      }
      containing.add(
          chosenContainer); //add to keep track of containers with altered content
      containers[chosenContainer] = level[i]; //apply change to containers
    }
  }

  void containerPeaker() async {
    //show whats "underneath" each tile
    buttonsDisabled = true;
    List<int> peaked = [];
    int peaking = 0;
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < containers.length; i++) {
      while (peaked.contains(peaking)) {
        peaking = _random.nextInt(containers.length);
      }
      peaked.add(peaking);
      if (this.mounted) {
        setState(() {
          containerHide[peaking] =
              containers[peaking]; //reveal color under tile
        });
      }
      await Future.delayed(Duration(seconds: 1));
      containerHide[peaking] = Colors.green; //after time, set back to default
    }
    if (this.mounted) {
      setState(() {});
    }
    buttonsDisabled = false;
  }

  void checkMatchClick(int buttonNum) async {
    //logic for clicking square
    if (containers[buttonNum] == matchObject) {
      //check if the clicked button matches the object in middle
      successes++;
      setState(() {
        correct = 1; //change icon for feedback - 1 is a tick, 2 is a cross
      });
      await Future.delayed(Duration(seconds: 1)); //display feedback
      if (successes < levels.length && this.mounted) {
        //as long as there are more levels, go to next.
        setState(() {
          containerContent(levels[successes]);
          containerPeaker();
        });
      } else {
        //if there are no more levels, end the test.
        t.cancel();
        widget.onResultChange(0);
        setState(() {
          testLive = false; //if all levels completed within time, end the test.
        });
      }
    } else {
      setState(() {
        correct = 2; //change icon for feedback - 2 is a cross
      });
      await Future.delayed(Duration(seconds: 1)); //display feedback
      //if a mistake has been made, repeat current step.
      mistakes++;
      if (this.mounted) {
        setState(() {
          containerContent(levels[successes]);
          containerPeaker();
        });
      }
    }
  }

  BoxDecoration objectDecor() {
    return BoxDecoration(
      color: matchObject,
      border: Border.all(
        width: 3,
      ),
    );
  }

  @override
  initState() {
    super.initState();
    levels.addAll(
        [shapes1, shapes2, shapes3, shapes4]); //hard add all levels?? :/
    containerContent(
        levels[successes]); //call containerContent with 0 before beginning.
  }

  @override
  Widget build(BuildContext context) {
    //consists of a column with 5 rows of content
    if (testBegin) {
      return Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Click the corresponding tile",
                    style: TextStyle(fontSize: 16)),
                OutlineButton(onPressed: () {
                  testStarter();
                }),
                Text("Tap the button when ready.",
                    style: TextStyle(fontSize: 16)),
              ]),
        ],
      ));
    } else if (testLive) {
      return Expanded(
          child: Column(
              //layout - consists of a column with 5 rows sctructuring the test screen. can rotate screen
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, //upper most
                children: <Widget>[
                  _makeButton(0),
                ]),
            Row(
                //double row 1
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _makeButton(1),
                  Container(
                    width: 30,
                  ),
                  _makeButton(2),
                ]),
            Row(
                //row with container for object
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: objectDecor(),
                    height: 60,
                    width: 60,
                    child: _getIcon(),
                  )
                ]),
            Row(
                //double row 2
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _makeButton(3),
                  Container(
                    width: 30,
                  ),
                  _makeButton(4),
                ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, //lower most
                children: <Widget>[
                 _makeButton(5),
                ]),
          ]));
    } else {
      return Container(
          padding: EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('The test is done!', style: TextStyle(fontSize: 22)),
                      Text('Correct: $successes, Wrong: $mistakes',
                          style: TextStyle(fontSize: 22)),
                    ]),
              ]));
    }
  }

  Widget _getIcon() { //show feedback icons on object to match
    if (correct == 0) {
      //nothing happens - no icon to show
    } else if (correct == 1) {
      return Icon(Icons.check, size: 40);
    } else {
      return Icon(Icons.clear, size: 40);
    }
  }

  Widget _makeButton(int buttonNumber) { //make material buttons for outter tiles to match with
    return (MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5),
            side: BorderSide(color: Colors.black, width: 3)),
        height: 60,
        minWidth: 60,
        color: containerHide[buttonNumber], //let containerHide control the look of button
        onPressed: () {
          if (!buttonsDisabled) {
            checkMatchClick(buttonNumber); //check if click was correct if all tiles have been peaked
          }
        }));
  }
}
