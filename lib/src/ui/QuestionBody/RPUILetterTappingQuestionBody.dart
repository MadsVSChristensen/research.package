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

  @override
  initState() {
    super.initState();
    player = AudioCache();
    //player.load('assets/sounds/heavy-rain-daniel_simon.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          player.play(
              'packages/research_package/assets/sounds/heavy-rain-daniel_simon.mp3');
        },
      ),
    );
  }
}
