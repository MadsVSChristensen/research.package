part of research_package_ui;

/// The UI representation of the [RPQuestionStep]. This widget is the container, the concrete content depends on the input step's [RPAnswerFormat].
///
/// As soon as the participant has finished with the question the [RPStepResult] is being added to the [RPTaskResult]'s result list.
class RPUIActivityStep extends StatefulWidget {
  final RPActivityStep step;

  RPUIActivityStep(this.step);

  @override
  _RPUIActivityStepState createState() => _RPUIActivityStepState();
}

class _RPUIActivityStepState extends State<RPUIActivityStep>
    with CanSaveResult {
  // Dynamic because we don't know what value the RPChoice will have
  dynamic _currentActivityBodyResult;
  bool readyToProceed;
  RPStepResult result;
  RPTaskProgress recentTaskProgress;

  set currentActivityBodyResult(dynamic currentActivityBodyResult) {
    this._currentActivityBodyResult = currentActivityBodyResult;
    if (this._currentActivityBodyResult != null) {
      setState(() {
        readyToProceed = true;
      });
    } else {
      setState(() {
        readyToProceed = false;
      });
    }
  }

  @override
  void initState() {
    // Instantiating the result object here to start the time counter (startDate)
    result = RPStepResult.withParams(widget.step);
    readyToProceed = false;
    recentTaskProgress = blocTask.lastProgressValue;

    super.initState();
  }

  // Returning the according step body widget based on the answerFormat of the step
  Widget stepBody(RPAnswerFormat answerFormat) {
    switch (answerFormat.runtimeType) {
      case RPIntegerAnswerFormat:
        return RPUIIntegerQuestionBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      case RPChoiceAnswerFormat:
        return RPUIChoiceQuestionBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      case RPSliderAnswerFormat:
        return RPUISliderQuestionBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      case RPImageChoiceAnswerFormat:
        return RPUIImageChoiceQuestionBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      case RPDateTimeAnswerFormat:
        return RPUIDateTimeQuestionBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      /* case RPTrailMakerAnswerFormat:
        return RPUITrailMakerActivityBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        }); */
      case RPTappingAnswerFormat:
        return RPUITappingActivityBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      case RPReactionTimeAnswerFormat:
        return RPUIReactionTimeActivityBody(answerFormat, (result) {
          this.currentActivityBodyResult = result;
        });
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stepBody(widget.step.answerFormat),
        ],
      ),
       persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () => blocTask.sendStatus(StepStatus.Canceled),
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text(
            "NEXT",
          ),
          onPressed: readyToProceed
              ? () {
                  // Communicating with the RPUITask Widget
                  blocTask.sendStatus(StepStatus.Finished);
                  createAndSendResult();
                }
              : null,
        ),
      ],
    );
    
  }

/* body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          title(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: stepBody(widget.step.answerFormat),
              ),
            ),
          ),
        ],
      ), */

  // Render the title above the ActivityBody
  Widget title() {
    if (widget.step.title != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 8, right: 8, top: 8),
        child: Text(
          widget.step.title,
          style: RPStyles.h2,
          textAlign: TextAlign.left,
        ),
      );
    }
    return null;
  }

  @override
  void createAndSendResult() {
    // Populate the result object with value and end the time tracker (set endDate)
    result.setResult(_currentActivityBodyResult);
    blocTask.sendStepResult(result);
  }
}
