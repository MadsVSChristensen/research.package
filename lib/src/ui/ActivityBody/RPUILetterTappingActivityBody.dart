part of research_package_ui;

class RPUILetterTappingActivityBody extends StatefulWidget {
  final RPLetterTappingActivity activity;
  final Function(dynamic) onResultChange;
  //final RPActivityGestureController gestureController;

  RPUILetterTappingActivityBody(this.activity, this.onResultChange);
//this.gestureController,

  @override
  _RPUILetterTappingActivityBodyState createState() =>
      _RPUILetterTappingActivityBodyState();
}

class _RPUILetterTappingActivityBodyState
    extends State<RPUILetterTappingActivityBody> {
  AudioCache player;
  AudioPlayer audioPlayer;
  String currentLetter;
  String lastLetter;
  int errors = 0;
  Timer timer;
  bool shouldTap;
  bool lastWasTapped;
  bool wasTapped;
  ActivityStatus activityStatus;
  List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  List<String> mocaTestList = [
    'F',
    'B',
    'A',
    'C',
    'M',
    'N',
    'A',
    'A',
    'J',
    'K',
    'L',
    'B',
    'A',
    'F',
    'A',
    'K',
    'D',
    'E',
    'A',
    'A',
    'A',
    'J',
    'A',
    'M',
    'O',
    'F',
    'A',
    'A',
    'B'
  ];

  @override
  initState() {
    super.initState();
    setState(() {
      activityStatus = ActivityStatus.Instruction;
    });
    currentLetter = '';
    lastLetter = '';
    audioPlayer = AudioPlayer();
    player = AudioCache(
        prefix: 'packages/research_package/assets/sounds/',
        fixedPlayer: audioPlayer);
    player.loadAll(alphabet.map((item) => (item + '.mp3')).toList());
  }

  void testControl() async {
    setState(() {
      activityStatus = ActivityStatus.Task;
    });
    await Future.delayed(Duration(seconds: 2));
    for (String letter in mocaTestList) {
      player.play('$letter.mp3');
      updateLetter(letter);
      await Future.delayed(Duration(milliseconds: 1000));
    }
    updateLetter('');
    widget.onResultChange({"Errors": errors});
    if (this.mounted) {
      setState(() {
        activityStatus = ActivityStatus.Result;
      });
    }
  }

  void updateLetter(String newLetter) {
    if (lastLetter == 'A' && !lastWasTapped) {
      errors += 1;
      print(
          'Error at $lastLetter $currentLetter - Last letter was A but wasTapped = false at update time (forgot to tap)');
    }
    lastWasTapped = wasTapped;
    wasTapped = false;
    lastLetter = currentLetter;
    currentLetter = newLetter;
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
                'Tap the button on the next screen, whenever you hear the letter "A" being said.',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Letterintro.png'))),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onPressed: () {
                  testControl();
                },
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      case ActivityStatus.Task:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
              width: 100,
              height: 60,
              child: OutlineButton(
                child: Text('A'),
                onPressed: () {
                  // X - X
                  if (currentLetter != 'A' && lastLetter != 'A') {
                    errors += 1;
                    print(
                        'Error at $lastLetter $currentLetter - Tapped while current letter and last letter were not A');
                  }
                  // A - A
                  if (lastLetter == 'A' && currentLetter == 'A') {
                    if (!lastWasTapped) {
                      lastWasTapped = true;
                    } else if (lastWasTapped && !wasTapped) {
                      wasTapped = true;
                    } else {
                      errors += 1;
                      print(
                          'Error at $lastLetter $currentLetter - Last and current were already tapped');
                    }
                  }
                  // A - X
                  if (lastLetter == 'A' && currentLetter != 'A') {
                    if (lastWasTapped) {
                      errors += 1;
                      print(
                          'Error at $lastLetter $currentLetter - Tapped last letter as it was A, but it was already tapped');
                    }
                  }
                  // X - A
                  if (lastLetter != 'A' && currentLetter == 'A') {
                    if (wasTapped) {
                      errors += 1;
                      print(
                          'Error at $lastLetter $currentLetter - Tapped current letter A while wasTapped = true');
                    } else {
                      wasTapped = true;
                    }
                  }
                },
              ),
            )
            ],)
          ],
        );
      case ActivityStatus.Result:
        return Container(
          child: Center(
            child: Text('You had $errors mistakes'),
          ),
        );
    }
  }
}
