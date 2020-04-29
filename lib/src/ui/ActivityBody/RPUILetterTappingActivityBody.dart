part of research_package_ui;

class RPUILetterTappingActivityBody extends StatefulWidget {
  final RPLetterTappingActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityGestureLogger gestureLogger;

  RPUILetterTappingActivityBody(
      this.activity, this.gestureLogger, this.onResultChange);

  @override
  _RPUILetterTappingActivityBodyState createState() =>
      _RPUILetterTappingActivityBodyState();
}

class _RPUILetterTappingActivityBodyState
    extends State<RPUILetterTappingActivityBody> {
  SoundService soundService;
  AudioCache player;
  AudioPlayer audioPlayer;
  String currentLetter;
  String lastLetter;
  int errors = 0;
  Timer timer;
  bool shouldTap;
  bool lastWasTapped;
  bool wasTapped;
  int letterIndex = 0;
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
    if (widget.activity.includeInstructions) {
      activityStatus = ActivityStatus.Instruction;
      widget.gestureLogger.instructionStarted();
    } else {
      activityStatus = ActivityStatus.Task;
      widget.gestureLogger.instructionStarted();
    }
    soundService = SoundService(alphabet
        .map((item) => ('../packages/research_package/assets/sounds/$item.mp3'))
        .toList());
    currentLetter = '';
    lastLetter = '';
  }

  void testInit() async {
    widget.gestureLogger.instructionEnded();
    widget.gestureLogger.testStarted();
    setState(() {
      activityStatus = ActivityStatus.Task;
    });
    await Future.delayed(Duration(seconds: 2));
    for (String letter in mocaTestList) {
      if (!this.mounted) break;
      soundService
          .play('../packages/research_package/assets/sounds/$letter.mp3');
      updateLetter(letter);
      await Future.delayed(Duration(milliseconds: 1000));
      if (letterIndex < 28) letterIndex += 1;
    }
    updateLetter('');
    if (this.mounted) {
      widget.onResultChange(errors);
      widget.gestureLogger.testEnded();
      if (widget.activity.includeResults) {
        widget.gestureLogger.resultsShown();
        setState(() {
          activityStatus = ActivityStatus.Result;
        });
      }
    }
  }

  void updateLetter(String newLetter) {
    if (lastLetter == 'A' && !lastWasTapped) {
      errors += 1;
      print(
          'Error at $lastLetter $currentLetter - Last letter was A but wasTapped = false at update time (forgot to tap)');
    }
    widget.gestureLogger.addWrongGesture('Missed button tap',
        'Did not press button on: ${mocaTestList.getRange(0, letterIndex)} >A< ${mocaTestList.getRange(letterIndex, mocaTestList.length - 1)}');
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
                  testInit();
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
            Container(
              width: 100,
              height: 60,
              child: OutlineButton(
                child: Text('A'),
                onPressed: () {
                  // X - X
                  if (currentLetter != 'A' && lastLetter != 'A') {
                    errors += 1;
                    String s =
                        '${(letterIndex > 0) ? mocaTestList.getRange(0, letterIndex - 1) : ''}' +
                            '>$currentLetter<' +
                            '${mocaTestList.getRange(letterIndex + 1, mocaTestList.length - 1)}';
                    widget.gestureLogger.addWrongGesture(
                        'Button tap', 'Pressed button on wrong letter: $s');
                  }
                  // A - A
                  if (lastLetter == 'A' && currentLetter == 'A') {
                    if (!lastWasTapped) {
                      widget.gestureLogger.addCorrectGesture('Button tap',
                          'Tapped letter with a delay: ${mocaTestList.getRange(0, letterIndex - 2)} >A< ${mocaTestList.getRange(letterIndex, mocaTestList.length - 1)}');
                      lastWasTapped = true;
                    } else if (lastWasTapped && !wasTapped) {
                      widget.gestureLogger.addCorrectGesture('Button tap',
                          'Tapped letter without delay: ${mocaTestList.getRange(0, letterIndex - 1)} >A< ${mocaTestList.getRange(letterIndex + 1, mocaTestList.length - 1)}');
                      wasTapped = true;
                    } else {
                      errors += 1;
                      widget.gestureLogger.addWrongGesture('Button tap',
                          'Tapped letter too many times: ${mocaTestList.getRange(0, letterIndex - 1)} >A< ${mocaTestList.getRange(letterIndex + 1, mocaTestList.length - 1)}');
//                      print(
//                          'Error at $lastLetter $currentLetter - Last and current were already tapped');
                    }
                  }
                  // A - X
                  if (lastLetter == 'A' && currentLetter != 'A') {
                    if (lastWasTapped) {
                      errors += 1;
                      widget.gestureLogger.addWrongGesture('Button tap',
                          'Tapped letter too many times: ${mocaTestList.getRange(0, letterIndex - 1)} >A< ${mocaTestList.getRange(letterIndex + 1, mocaTestList.length - 1)}');
//                      print(
//                          'Error at $lastLetter $currentLetter - Tapped last letter as it was A, but it was already tapped');
                    } else {
                      lastWasTapped = true;
                      widget.gestureLogger.addCorrectGesture('Button tap',
                          'Tapped letter with a delay: ${mocaTestList.getRange(0, letterIndex - 2)} >A< ${mocaTestList.getRange(letterIndex, mocaTestList.length - 1)}');
                    }
                  }
                  // X - A
                  if (lastLetter != 'A' && currentLetter == 'A') {
                    if (wasTapped) {
                      errors += 1;
                      widget.gestureLogger.addWrongGesture('Button tap',
                          'Tapped letter too many times: ${mocaTestList.getRange(0, letterIndex - 1)} >A< ${mocaTestList.getRange(letterIndex + 1, mocaTestList.length - 1)}');
//                      print(
//                          'Error at $lastLetter $currentLetter - Tapped current letter A while wasTapped = true');
                    } else {
                      wasTapped = true;
                      widget.gestureLogger.addCorrectGesture('Button tap',
                          'Tapped letter without delay: ${mocaTestList.getRange(0, letterIndex - 1)} >A< ${mocaTestList.getRange(letterIndex + 1, mocaTestList.length - 1)}');
                    }
                  }
                },
              ),
            )
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

class SoundService {
  final List<String> files;

  SoundService(this.files) {
    player.loadAll(files);
  }

  static final player = AudioCache();

  void play(String path) async {
    player.play(path, mode: PlayerMode.LOW_LATENCY);
  }
}

extension on Iterable<String> {
  List<String> get withoutAssetOnFront =>
      this.map((e) => e.withoutAssetOnFront).toList();
}

extension on String {
  String get withoutAssetOnFront => this.replaceFirst("assets/", "");
}
