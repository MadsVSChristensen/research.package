part of research_package_ui;

class RPUIPairedAssociatesLearningActivityBody extends StatefulWidget {
  final RPPairedAssociatesLearningActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityGestureController gestureController;

  RPUIPairedAssociatesLearningActivityBody(
      this.activity, this.gestureController, this.onResultChange);

  @override
  _RPUIPairedAssociatesLearningActivityBody createState() =>
      _RPUIPairedAssociatesLearningActivityBody();
}

class _RPUIPairedAssociatesLearningActivityBody
    extends State<RPUIPairedAssociatesLearningActivityBody> {
  final _random = new Random();
  ActivityStatus activityStatus;
  bool buttonsDisabled =
      false; //diable when peaking tiles and when checking result
  int correct =
      0; //introduce int that can be 0, 1 and 2 for three possibilities. (indicates if, and which icon to show)
  int successes = 0;
  int mistakes = 0;
  int testDuration = 40; //test duration in seconds - time untill window changes
  Timer t = new Timer(Duration(seconds: 0),
      () {}); //construct for further control of timer. Cancel at window collapse.
  List<String> containers = [
    'assets/images/nothing.png',
    'assets/images/nothing.png',
    'assets/images/nothing.png',
    'assets/images/nothing.png',
    'assets/images/nothing.png',
    'assets/images/nothing.png'
  ]; //a container can be empty, default values, or have a shape
  List<String> containerHide = [
    'assets/images/hidden.png',
    'assets/images/hidden.png',
    'assets/images/hidden.png',
    'assets/images/hidden.png',
    'assets/images/hidden.png',
    'assets/images/hidden.png'
  ];
  List<String> shapes0 = ['assets/images/shape1.png'];
  List<String> shapes1 = [
    'assets/images/shape1.png',
    'assets/images/shape2.png'
  ]; //colors for inital logic setup
  List<String> shapes2 = [
    'assets/images/shape1.png',
    'assets/images/shape2.png',
    'assets/images/shape3.png'
  ];
  List<List> levels = []; //list of all levels. Add in init.
  String matchObject = '';

  @override
  initState() {
    super.initState();
    activityStatus = ActivityStatus.Instruction;
    levels.addAll([shapes0, shapes1, shapes2]); //hard add all levels...
    containerContent(
        levels[successes]); //call containerContent with 0 before beginning.
  }

  void testStarter() {
    //begin test by changing window and starting timer.
    setState(() {
      activityStatus = ActivityStatus.Task;
    });
    containerPeaker();
    t = Timer(Duration(seconds: testDuration), () {
      //when time is up, change window and set result
      activityStatus = ActivityStatus.Result;
      if (this.mounted) {
        widget.onResultChange(0);
      }
    });
  }

  void containerContent(level) {
    correct = 0; //set no feedback icon.
    //fill containers with content
    for (int i = 0; i < containers.length; i++) {
      //let all containers be the same from start of levels.
      containers[i] = 'assets/images/nothing.png';
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
          containerHide[peaking] = containers[peaking]; //reveal tile
        });
      }
      await Future.delayed(Duration(seconds: 1));
      containerHide[peaking] =
          'assets/images/hidden.png'; //after time, set back to default
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
          activityStatus = ActivityStatus
              .Result; //if all levels completed within time, end the test.
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

  @override
  Widget build(BuildContext context) {
    //consists of a column with 5 rows of content
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "A screen with 6 tiles will appear. Whats underneath will be revealed one by one. Click the tile matching the object in the middle, when the reveal is done.",
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
              onPressed: () {
                testStarter();
              },
              child: Text('Ready'),
            ),
          ],
        );
      case ActivityStatus.Task:
        return Column(
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
            ]);
      case ActivityStatus.Result:
        return Container(
            padding: EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('The test is done!',
                            style: TextStyle(fontSize: 22)),
                        Text('Correct: $successes, Wrong: $mistakes',
                            style: TextStyle(fontSize: 22)),
                      ]),
                ]));
    }
  }

  BoxDecoration objectDecor() {
    return BoxDecoration(
      //color: matchObject,
      border: Border.all(
        width: 3,
      ),
      borderRadius: new BorderRadius.circular(5),
      image: DecorationImage(fit: BoxFit.fill, image: AssetImage(matchObject)),
    );
  }

  Widget _getIcon() {
    //show feedback icons on object to match
    if (correct == 0) {
      //nothing happens - no icon to show
    } else if (correct == 1) {
      return Icon(Icons.check, size: 50);
    } else {
      return Icon(Icons.clear, size: 50);
    }
  }

  Widget _makeButton(int buttonNumber) {
    //make material buttons for outter tiles to match with
    return (Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(containerHide[buttonNumber])),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5),
              side: BorderSide(color: Colors.black, width: 3)),
          onPressed: () {
            if (!buttonsDisabled) {
              buttonsDisabled = true;
              checkMatchClick(
                  buttonNumber); //check if click was correct if all tiles have been peaked
            }
          },
        )));
  }
}
