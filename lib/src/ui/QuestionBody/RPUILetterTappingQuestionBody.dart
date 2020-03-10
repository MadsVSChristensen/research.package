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

  @override
  initState() {
    super.initState();
    currentLetter = '';
    audioPlayer = AudioPlayer();
    player = AudioCache(
        prefix: 'packages/research_package/assets/sounds/',
        fixedPlayer: audioPlayer);
    player.loadAll([
      'A.mp3',
      'B.mp3',
      'C.mp3',
      'D.mp3',
      'E.mp3',
      'F.mp3',
      'G.mp3',
      'H.mp3',
      'I.mp3',
      'J.mp3',
      'K.mp3',
      'L.mp3',
      'M.mp3',
      'N.mp3',
      'O.mp3',
      'P.mp3',
      'Q.mp3',
      'R.mp3',
      'S.mp3',
      'T.mp3',
      'U.mp3',
      'V.mp3',
      'W.mp3',
      'X.mp3',
      'Y.mp3',
      'Z.mp3',
    ]);
  }

  void updateLetter(String newLetter) {
    if (currentLetter == 'A' && !wasTapped) {
      errors += 1;
    }
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
                        player.play('A.mp3');
                        updateLetter('A');
                        await Future.delayed(Duration(seconds: 1));
                        wasTapped = false;
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
                        await Future.delayed(Duration(seconds: 1));
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
                          }
                          if (currentLetter == 'A') {
                            if (wasTapped) {
                              errors += 1;
                            } else {
                              wasTapped = true;
                            }
                          }
                        })
            ],
          ));
  }
}
