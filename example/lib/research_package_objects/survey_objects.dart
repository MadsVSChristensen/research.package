import 'package:research_package/model.dart';

List<RPChoice> answers = [
  RPChoice.withParams("Strongly agree", 4),
  RPChoice.withParams("Agree", 3),
  RPChoice.withParams("Neither agree nor disagree", 2),
  RPChoice.withParams("Disagree", 1),
  RPChoice.withParams("Strongly disagree", 0),
];

RPChoiceAnswerFormat answerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, answers);

RPQuestionStep Q1 = RPQuestionStep.withAnswerFormat("RulesQuestionID",
    "The rules made it clear, what I was supposed to do.", answerFormat);
RPQuestionStep Q2 = RPQuestionStep.withAnswerFormat(
    "IntroQuestionID",
    "The example pictures on the instruction page, helped me understand what I was supposed to do.",
    answerFormat);
RPQuestionStep Q3 = RPQuestionStep.withAnswerFormat("TaskExecutionQuestionID",
    "I felt like I was able to carry out the tests.", answerFormat);
RPQuestionStep Q4 = RPQuestionStep.withAnswerFormat("TestConfusionQuestionID",
    "I felt like performing the tests was confusing.", answerFormat);
RPQuestionStep Q5 = RPQuestionStep.withAnswerFormat(
    "ResultQuestionID", "The results I got, made sense to me.", answerFormat);

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
    rapidVisualInfoProcessingStep,
    pairedAssociatesLearningStep,
    reactionTimeStep,
    tappingStep,
    corsiBlockTapping,
    stroopEffect,
    activityStepTrail,
    activityStepLetterTapping,
    Q1,
    Q2,
    Q3,
    Q4,
    Q5,
    completionStep,
  ],
);
