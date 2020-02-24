part of research_package_ui;

class RPUITrailMakingActivityBody extends StatefulWidget {
  final RPTrailMakingAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUITrailMakingActivityBody(this.answerFormat, this.onResultChange);

  @override
  _RPUITrailMakingActivityBodyState createState() =>
      _RPUITrailMakingActivityBodyState();
}

class _RPUITrailMakingActivityBodyState
    extends State<RPUITrailMakingActivityBody> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: _TrailPainter(),
      ),
    );
  }
}

class _TrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
