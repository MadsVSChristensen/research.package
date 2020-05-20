import 'package:research_package/model.dart';

List<RPChoice> answers = [
  RPChoice.withParams("5    (Strongly agree)", 4),
  RPChoice.withParams("4", 3),
  RPChoice.withParams("3", 2),
  RPChoice.withParams("2", 1),
  RPChoice.withParams("1    (Strongly disagree)", 0),
];
List<RPChoice> genderAnswers = [
  RPChoice.withParams("Male", 1),
  RPChoice.withParams("Female", 0),
];

RPInstructionStep instructionStep = RPInstructionStep(
    identifier: "instruction", title: 'Questionnaire section')
  ..text =
      "Please answer the following questions on a scale of 1 to 5. \n1 being 'Strongly disagree' and 5 being 'Strongly agree'";

RPIntegerAnswerFormat ageAnswerFormat =
    RPIntegerAnswerFormat.withParams(10, 100, "years");

RPChoiceAnswerFormat genderAnswerFormat = RPChoiceAnswerFormat.withParams(
    ChoiceAnswerStyle.SingleChoice, genderAnswers);

RPChoiceAnswerFormat answerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, answers);

RPQuestionStep genderQuestion = RPQuestionStep.withAnswerFormat(
    "gender", "Select your gender below", genderAnswerFormat);
RPQuestionStep ageQuestion = RPQuestionStep.withAnswerFormat(
    "age", "Select your age below", ageAnswerFormat);

RPQuestionStep Q1 = RPQuestionStep.withAnswerFormat(
    "Q1",
    "I think that I would like to use these tests frequently, if I wanted to track my cognitive state.",
    answerFormat);
RPQuestionStep Q2 = RPQuestionStep.withAnswerFormat(
    "Q2", "I found the tests unnecessarily complex.", answerFormat);
RPQuestionStep Q3 = RPQuestionStep.withAnswerFormat(
    "Q3", "I thought the app was easy to use.", answerFormat);
RPQuestionStep Q4 = RPQuestionStep.withAnswerFormat(
    "Q4",
    "I think that I would need the support of a technical person to be able to use this app.",
    answerFormat);
RPQuestionStep Q5 = RPQuestionStep.withAnswerFormat(
    "Q5",
    "I found the various functions in this app were well integrated.",
    answerFormat);
RPQuestionStep Q6 = RPQuestionStep.withAnswerFormat("Q6",
    "I thought there was too much inconsistency in these tests.", answerFormat);
RPQuestionStep Q7 = RPQuestionStep.withAnswerFormat(
    "Q7",
    "I would imagine that most people would learn to use this app very quickly.",
    answerFormat);
RPQuestionStep Q8 = RPQuestionStep.withAnswerFormat(
    "Q8", "I found the tests very cumbersome to do.", answerFormat);
RPQuestionStep Q9 = RPQuestionStep.withAnswerFormat(
    "Q9", "I felt very confident using the app.", answerFormat);
RPQuestionStep Q10 = RPQuestionStep.withAnswerFormat(
    "Q10",
    "I needed to learn a lot of things before I could get going with these tests.",
    answerFormat);

RPCompletionStep completionStep = RPCompletionStep("completionID")
  ..title = "Finished"
  ..text = "Thank you for taking the tests";

RPActivityStep tappingStep = RPTappingActivity(
  'Tapping step ID',
);

RPActivityStep reactionTimeStep = RPReactionTimeActivity(
  'Reaction Time step ID',
);

RPActivityStep rapidVisualInfoProcessingStep =
    RPRapidVisualInfoProcessingActivity(
  'RVIP step ID',
);

RPActivityStep activityStepTrail = RPTrailMakingActivity(
  'Trail Making step ID',
);

RPActivityStep activityStepLetterTapping = RPLetterTappingActivity(
  'Letter Tapping step ID',
);

RPActivityStep pairedAssociatesLearningStep =
    RPPairedAssociatesLearningActivity(
  'PAL step ID',
);

RPActivityStep corsiBlockTapping = RPCorsiBlockTappingActivity(
  'Corsi Block Tapping step ID',
);

RPActivityStep stroopEffect = RPStroopEffectActivity(
  'Stroop Effect step ID',
);

RPOrderedTask surveyTask = RPOrderedTask(
  "surveyTaskID",
  [
    genderQuestion,
    ageQuestion,
    rapidVisualInfoProcessingStep,
    pairedAssociatesLearningStep,
    reactionTimeStep,
    tappingStep,
    corsiBlockTapping,
    stroopEffect,
    activityStepTrail,
    activityStepLetterTapping,
    instructionStep,
    Q1,
    Q2,
    Q3,
    Q4,
    Q5,
    Q6,
    Q7,
    Q8,
    Q9,
    Q10,
    completionStep,
  ],
);
