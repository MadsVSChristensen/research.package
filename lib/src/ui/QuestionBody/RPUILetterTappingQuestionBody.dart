part of research_package_ui;

class RPUILetterTappingActivityBody extends StatefulWidget {
  final RPLetterTappingAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUILetterTappingActivityBody(this.answerFormat, this.onResultChange);

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
  int errors = 0;
  Timer timer;
  bool shouldTap;
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
    audioPlayer = AudioPlayer();
    player = AudioCache(
        prefix: 'packages/research_package/assets/sounds/',
        fixedPlayer: audioPlayer);
    player.loadAll(alphabet.map((item) => (item + '.mp3')).toList());
  }

  void updateLetter(String newLetter) {
    if (currentLetter == 'A' && !wasTapped) {
      errors += 1;
      print(
          'Error at letter $currentLetter - Letter was A but wasTapped = false at update time (forgot to tap)');
    }
    wasTapped = false;
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
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
                          updateLetter(letter);
                          player.play('$letter.mp3');
                          await Future.delayed(Duration(seconds: 1));
                        }

                        /* player.play('A.mp3');
                        updateLetter('A');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('B.mp3');
                        updateLetter('B');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('C.mp3');
                        updateLetter('C');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('D.mp3');
                        updateLetter('D');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('E.mp3');
                        updateLetter('E');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('F.mp3');
                        updateLetter('F');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('G.mp3');
                        updateLetter('G');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('H.mp3');
                        updateLetter('H');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('I.mp3');
                        updateLetter('I');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('J.mp3');
                        updateLetter('J');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('K.mp3');
                        updateLetter('K');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('L.mp3');
                        updateLetter('L');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('M.mp3');
                        updateLetter('M');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('N.mp3');
                        updateLetter('N');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('O.mp3');
                        updateLetter('O');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('P.mp3');
                        updateLetter('P');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('Q.mp3');
                        updateLetter('Q');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('R.mp3');
                        updateLetter('R');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('S.mp3');
                        updateLetter('S');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('T.mp3');
                        updateLetter('T');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('U.mp3');
                        updateLetter('U');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('V.mp3');
                        updateLetter('V');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('W.mp3');
                        updateLetter('W');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('X.mp3');
                        updateLetter('X');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('Y.mp3');
                        updateLetter('Y');
                        await Future.delayed(Duration(seconds: 1));
                        player.play('Z.mp3');
                        updateLetter('Z');
                        await Future.delayed(Duration(seconds: 1)); */

                        updateLetter('');
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
                          if (currentLetter != 'A') {
                            errors += 1;
                            print(
                                'Error at letter $currentLetter - Tapped while current letter not A');
                          }
                          if (currentLetter == 'A') {
                            if (wasTapped) {
                              errors += 1;
                              print(
                                  'Error at letter $currentLetter - Tapped letter A while wasTapped = true (tapped too many times)');
                            } else {
                              wasTapped = true;
                            }
                          }
                        })
            ],
          ));
  }
}
