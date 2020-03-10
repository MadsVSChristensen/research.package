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
  _PathTracker _pathTracker = _PathTracker();

  @override
  initState() {
    super.initState();
  }

  void _onPanStart(DragStartDetails start) {
    print('onPanStart');
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    _pathTracker.addNewPath(pos);
    _pathTracker.notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    _pathTracker.updateCurrentPath(pos);
    _pathTracker.notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    _pathTracker.endCurrentPath(widget.onResultChange);
    _pathTracker.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 400,
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: ClipRect(
          child: CustomPaint(
            painter: _TrailPainter(_pathTracker),
          ),
        ),
      ),
    );
  }
}

class _TrailPainter extends CustomPainter {
  _PathTracker _pathsTracker;

  _TrailPainter(this._pathsTracker) : super(repaint: _pathsTracker);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        Paint()..color = Colors.white);
    for (_Location location in _pathsTracker._locations) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: location.id,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, location.offset);
      canvas.drawRect(
          location.rect,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0);
      // canvas.drawCircle(
      //     offset,
      //     10,
      //     Paint()
      //       ..color = Colors.black
      //       ..style = PaintingStyle.stroke
      //       ..strokeWidth = 1.0);
    }
    for (Path path in _pathsTracker._paths) {
      canvas.drawPath(
          path,
          (Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _PathTracker extends ChangeNotifier {
  List<Path> _paths;
  List<_Location> _locations;
  bool _isDraging;
  _Location prevLocation;
  _Location nextLocation;
  int index;

  _PathTracker() {
    _paths = List<Path>();
    _locations = List<_Location>();
    _locations.add(_Location('A', Offset(30, 500),
        Rect.fromCircle(center: Offset(30, 500), radius: 20)));
    _locations.add(_Location('B', Offset(350, 550),
        Rect.fromCircle(center: Offset(350, 550), radius: 20)));
    _locations.add(_Location('C', Offset(250, 400),
        Rect.fromCircle(center: Offset(250, 400), radius: 20)));
    _locations.add(_Location('D', Offset(100, 50),
        Rect.fromCircle(center: Offset(100, 50), radius: 20)));
    _locations.add(_Location('E', Offset(350, 100),
        Rect.fromCircle(center: Offset(350, 100), radius: 20)));
    _isDraging = false;
    prevLocation = _locations.first;
    nextLocation = _locations[1];
    index = 1;
  }

  void addNewPath(Offset pos) {
    print('Add new pos at $pos');
    if (!_isDraging) {
      _isDraging = true;
      Path path = Path();
      path.moveTo(pos.dx, pos.dy);
      _paths.add(path);
    }
  }

  void updateCurrentPath(Offset newPos) {
    if (_isDraging) {
      Path path = _paths.last;
      path.lineTo(newPos.dx, newPos.dy);
    }
  }

  void endCurrentPath(Function(dynamic) onResultChange) {
    print('end');
    _isDraging = false;
    Path path = _paths.last;
    Offset lastPoint = path
        .computeMetrics()
        .last
        .getTangentForOffset(path.computeMetrics().last.length)
        .position;
    Offset firstPoint =
        path.computeMetrics().first.getTangentForOffset(0).position;
    print('First point was $firstPoint      Last point was $lastPoint');
    print('contains first point ${prevLocation.rect.contains(firstPoint)}');
    print('contains last point  ${nextLocation.rect.contains(lastPoint)}');
    if (prevLocation.rect.contains(firstPoint) &&
        nextLocation.rect.contains(lastPoint)) {
      print('good end');
      prevLocation = nextLocation;
      if (index < _locations.length - 1) {
        index += 1;
        nextLocation = _locations[index];
      } else {
        print('finished');
        onResultChange(true);
      }
    } else {
      print('bad end');
      deleteWrong();
    }
  }

  // TODO: add logic
  void deleteWrong() {
    if (!_isDraging) {
      _paths.removeLast();
    }
  }
}

class _Location {
  String id;
  Offset offset;
  Rect rect;

  _Location(this.id, this.offset, this.rect);
}
