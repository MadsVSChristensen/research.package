part of research_package_ui;

class RPUICorsiBlockTappingActivityBody extends StatefulWidget {
  final RPCorsiBlockTappingAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  RPUICorsiBlockTappingActivityBody(this.answerFormat, this.onResultChange);

  @override
  _RPUICorsiBlockTappingActivityBodyState createState() =>
      _RPUICorsiBlockTappingActivityBodyState();
}

class _RPUICorsiBlockTappingActivityBodyState
    extends State<RPUICorsiBlockTappingActivityBody> {
  ActivityStatus activityStatus;
  int corsiSpan = 0;
  int highlightedBlockID;
  List<int> blocks;
  List<int> tapOrder = [];
  bool readyForTap = false;
  bool finishedTask = false;
  bool failedLast = false;
  String taskInfo = '';
  int numberOfBlocks = 2;

  @override
  initState() {
    super.initState();
    activityStatus = ActivityStatus.Instruction;
    blocks = List.generate(9, (index) => index);
  }

  void startTest() async {
    setState(() {
      taskInfo = 'Wait';
      readyForTap = false;
      tapOrder.clear();
      blocks.shuffle();
    });
    await Future.delayed(Duration(seconds: 1));
    for (int i = 0; i < numberOfBlocks; i++) {
      setState(() {
        highlightedBlockID = blocks[i];
      });
      await Future.delayed(Duration(milliseconds: 1000));
    }
    setState(() {
      highlightedBlockID = null;
      readyForTap = true;
      taskInfo = 'Go';
    });
  }

  void onBlockTap(int index) async {
    setState(() {
      tapOrder.add(index);
    });
    if (tapOrder.length == numberOfBlocks) {
      finishedTask = true;
      bool wasCorrect = true;
      for (int x = 0; x < numberOfBlocks; x++) {
        if (tapOrder[x] != blocks[x]) wasCorrect = false;
      }
      if (!wasCorrect) {
        if (failedLast) {
          setState(() {
            taskInfo = 'Finished';
          });
          this.widget.onResultChange(corsiSpan);
          await Future.delayed(Duration(milliseconds: 700));
          setState(() {
            activityStatus = ActivityStatus.Result;
          });
        } else {
          failedLast = true;
          setState(() {
            taskInfo = 'Try again';
          });
          await Future.delayed(Duration(milliseconds: 700));
          startTest();
        }
      } else {
        setState(() {
          taskInfo = 'Well done';
        });
        corsiSpan = numberOfBlocks;
        numberOfBlocks++;
        await Future.delayed(Duration(milliseconds: 700));
        startTest();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (activityStatus) {
      case ActivityStatus.Instruction:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'You will see 9 blocks. An increasing number of the blocks will be highlighted in order. When the light is green, you should press the blocks in the same order as they were highlighted.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            FlatButton(
              child: Text('Ready'),
              onPressed: () {
                setState(() {
                  activityStatus = ActivityStatus.Task;
                });
                startTest();
              },
            )
          ],
        );
        break;
      case ActivityStatus.Task:
        return Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70,
                width: 200,
                child: Center(
                  child: Text(
                    taskInfo,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                color: readyForTap ? Colors.green : Colors.red,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 0 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(0) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(0);
                          }
                        : null,
                  ),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 1 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(1) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(1);
                          }
                        : null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 2 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(2) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(2);
                          }
                        : null,
                  ),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 3 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(3) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(3);
                          }
                        : null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 4 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(4) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(4);
                          }
                        : null,
                  ),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 5 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(5) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(5);
                          }
                        : null,
                  ),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 6 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(6) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(6);
                          }
                        : null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 7 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(7) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(7);
                          }
                        : null,
                  ),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: 60,
                      color: highlightedBlockID == 8 ? Colors.red : Colors.blue,
                      child: Center(
                        child: tapOrder.contains(8) ? Icon(Icons.check) : null,
                      ),
                    ),
                    onTap: readyForTap
                        ? () {
                            onBlockTap(8);
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case ActivityStatus.Result:
        return Center(
          child: Text('Your Corsi Span was $corsiSpan'),
        );
      default:
        return Container();
    }
  }
}

enum ActivityStatus { Instruction, Task, Result }
