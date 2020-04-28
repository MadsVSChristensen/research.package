part of research_package_ui;

class RPUITrailMakingActivityBody extends StatefulWidget {
  final RPTrailMakingActivity activity;
  final Function(dynamic) onResultChange;
  final RPActivityGestureLogger gestureLogger;

  RPUITrailMakingActivityBody(
      this.activity, this.gestureLogger, this.onResultChange);

  @override
  _RPUITrailMakingActivityBodyState createState() =>
      _RPUITrailMakingActivityBodyState();
}

class _RPUITrailMakingActivityBodyState
    extends State<RPUITrailMakingActivityBody> {
  _PathTracker _pathTracker;
  ActivityStatus activityStatus;
  List<_Location> _boxLocations;
  //bool canvasLoaded = false;
  Future canvasReady;

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
  }

  Future<bool> buildCanvas(context) {
    Size size = MediaQuery.of(context).size;
    _boxLocations = _TrailMakingLists()
        .A(size.width, size.height - AppBar().preferredSize.height - 100);
    _pathTracker = _PathTracker(widget.gestureLogger, _boxLocations);
    print('${size.height}, ${AppBar().preferredSize.height}');
    print('future complete');
    return Future.value(true);
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    _pathTracker.addNewPath(pos);
    _pathTracker.notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    _pathTracker.updateCurrentPath(pos, testConcluded);
    _pathTracker.notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    _pathTracker.endCurrentPath();
    _pathTracker.notifyListeners();
  }

  void testConcluded(dynamic result) {
    widget.onResultChange({"Completion time": secondsUsed});
    if (widget.activity.includeResults) {
      widget.gestureLogger.resultsShown();
      if (this.mounted) {
        setState(() {
          activityStatus = ActivityStatus.Result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          //entry screen with rules and start button
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Connect the different boxes to each other in the right order',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
              onPressed: () {
                widget.gestureLogger.instructionEnded();
                widget.gestureLogger.testStarted();
                setState(() {
                  activityStatus = ActivityStatus.Task;
                });
              },
              child: Text(
                'Ready',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height/2.5,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Trailintro.png'))),
              ),
            ),
          ],
        );
        break;
      case ActivityStatus.Task:
        canvasReady = buildCanvas(context);
        return FutureBuilder(
          future: canvasReady,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
              width: MediaQuery.of(context).size.width,
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
          },
        );
        break;
      case ActivityStatus.Result:
        return Container(
          alignment: Alignment.center,
          child: Text('Youre done, or time slipped up'),
        );
        break;
    }
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
//        maxWidth: 0,
      );
      // offset for id 10, as it is wider than the rest.
      int tx = location.id == '10' ? 11 : 6;
      Offset textOffset =
          Offset(location.offset.dx - tx, location.offset.dy - 12);
      textPainter.paint(canvas, textOffset);
      canvas.drawRect(
          location.rect,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0);
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
  bool _isFinished = false;
  bool goodStart;
  bool taskStarted;
  _Location prevLocation;
  _Location nextLocation;
  int index;
  DateTime startTime;
  final RPActivityGestureLogger gestureController;

  _PathTracker(this.gestureController, this._locations) {
    _paths = List<Path>();
    _isDraging = false;
    taskStarted = false;
    prevLocation = _locations.first;
    nextLocation = _locations[1];
    index = 1;
  }

  void addNewPath(Offset pos) {
//    print('Add new pos at $pos');
    if (!taskStarted) {
      startTime = DateTime.now();
    }
    print(_isDraging);
    if (!_isDraging) {
      _isDraging = true;
      Path path = Path();
      path.moveTo(pos.dx, pos.dy);
      // starting point - also removes errors when trying to remove paths not yet drawn
      path.addOval(Rect.fromLTWH(pos.dx, pos.dy, 1, 1));
      _paths.add(path);
    }
  }

  void updateCurrentPath(Offset newPos, Function(dynamic) testConcluded) {
    if (_isDraging) {
      Path path = _paths.last;
      path.lineTo(newPos.dx, newPos.dy);
      Offset firstPoint =
          path.computeMetrics().first.getTangentForOffset(0).position;

      // Avoid if drag hits another locations before hitting the next location (e.g. A-C-B)
      List locationCopy = List.from(_locations);
      locationCopy.remove(prevLocation);
      locationCopy.remove(nextLocation);
      for (_Location l in locationCopy) {
        if (l.rect.contains(newPos)) {
          _isDraging = false;
          gestureController.addWrongGesture('Draw path',
              'Drew a path which hit ${l.id} instead of the correct, next item ${nextLocation.id}');
          deleteWrong();
          return;
        }
      }

      // If dragging directly without lifting finger
      if (prevLocation.rect.contains(firstPoint) &&
          nextLocation.rect.contains(newPos)) {
        gestureController.addCorrectGesture('Draw path',
            'Drew a correct path from ${prevLocation.id} to ${nextLocation.id}');
        Path newPath = Path();
        newPath.moveTo(newPos.dx, newPos.dy);
        _paths.add(newPath);
        prevLocation = nextLocation;
        if (index < _locations.length - 1) {
          index += 1;
          nextLocation = _locations[index];
        } else {
          print('finished');
          _isFinished = true;
          gestureController.testEnded();
          gestureController.resultsShown();
          int secondsUsed = DateTime.now().difference(startTime).inSeconds;
          testConcluded(secondsUsed);
          //onResultChange(secondsUsed);
        }
      }
    }
  }

  void endCurrentPath() {
    print('end');
    if (_isDraging) {
      _isDraging = false;
      if (!_isFinished) {
        Path path = _paths.last;
        print(path.computeMetrics());
        Offset lastPoint = path
            .computeMetrics(forceClosed: true)
            .last
            .getTangentForOffset(path.computeMetrics().last.length)
            .position;
        Offset firstPoint =
            path.computeMetrics().first.getTangentForOffset(0).position;
        if (!prevLocation.rect.contains(firstPoint)) {
          gestureController.addWrongGesture('Draw path',
              'Drew a path which didnt start in ${prevLocation.id}');
          deleteWrong();
        } else if (!nextLocation.rect.contains(lastPoint)) {
          gestureController.addWrongGesture(
              'Draw path', 'Drew a path which didnt end in ${nextLocation.id}');
          deleteWrong();
        }
      }
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

  _Location(this.id, this.offset) {
    rect = Rect.fromCircle(center: offset, radius: 26);
  }
}

class _TrailMakingLists {
  List<_Location> A(double w, double h) {
    return [
      _Location('1', Offset(w * 0.6, h * 0.5)),
      _Location('2', Offset(w * 0.17, h * 0.28)),
      _Location('3', Offset(w * 0.45, h * 0.08)),
      _Location('4', Offset(w * 0.55, h * 0.30)),
      _Location('5', Offset(w * 0.80, h * 0.20)),
      _Location('6', Offset(w * 0.85, h * 0.72)),
      _Location('7', Offset(w * 0.45, h * 0.60)),
      _Location('8', Offset(w * 0.60, h * 0.88)),
      _Location('9', Offset(w * 0.12, h * 0.92)),
      _Location('10', Offset(w * 0.2, h * 0.50)),
    ];
  }

  List<_Location> B(double w, double h) {
    return [
      _Location('1', Offset(w * 0.6, h * 0.5)),
      _Location('A', Offset(w * 0.17, h * 0.28)),
      _Location('2', Offset(w * 0.45, h * 0.08)),
      _Location('B', Offset(w * 0.55, h * 0.30)),
      _Location('3', Offset(w * 0.80, h * 0.20)),
      _Location('C', Offset(w * 0.85, h * 0.72)),
      _Location('4', Offset(w * 0.45, h * 0.60)),
      _Location('D', Offset(w * 0.60, h * 0.88)),
      _Location('5', Offset(w * 0.12, h * 0.92)),
      _Location('E', Offset(w * 0.2, h * 0.50)),
    ];
  }
}
