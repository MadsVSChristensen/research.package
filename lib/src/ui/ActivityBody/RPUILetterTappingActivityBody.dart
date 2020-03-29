part of research_package_ui;

class RPUILetterTappingActivityBody extends StatefulWidget {
  final RPLetterTappingActivity activity;
  final Function(dynamic) onResultChange;

  RPUILetterTappingActivityBody(this.activity, this.onResultChange);

  @override
  _RPUILetterTappingActivityBodyState createState() =>
      _RPUILetterTappingActivityBodyState();
}

class _RPUILetterTappingActivityBodyState
    extends State<RPUILetterTappingActivityBody> {
  AudioCache player;
  AudioPlayer audioPlayer;
  bool isPlaying = false;
  bool isFinished = false;
  String currentLetter;
  String lastLetter;
  int errors = 0;
  Timer timer;
  bool shouldTap;
  bool lastWasTapped;
  bool wasTapped;
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
    currentLetter = '';
    lastLetter = '';
    audioPlayer = AudioPlayer();
    player = AudioCache(
        prefix: 'packages/research_package/assets/sounds/',
        fixedPlayer: audioPlayer);
    player.loadAll(alphabet.map((item) => (item + '.mp3')).toList());
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
    return isFinished
        ? Container(
            child: Center(
              child: Text('You had $errors mistakes'),
            ),
          )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Press the start button to begin'),
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: isPlaying
                      ? null
                      : () async {
                          setState(() {
                            isPlaying = true;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          for (String letter in mocaTestList) {
                            player.play('$letter.mp3');
                            updateLetter(letter);
                            await Future.delayed(Duration(milliseconds: 1000));
                          }
                          updateLetter('');

                          // TODO: SetState error when survey is canceled
                          setState(() {
                            isPlaying = false;
                            isFinished = true;
                          });
                          widget.onResultChange(errors);
                        },
                ),
                FlatButton(
                  child: Icon(Icons.restaurant),
                  onPressed: !isPlaying
                      ? null
                      : () {
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
                )
              ],
            ),
          );
  }
}

