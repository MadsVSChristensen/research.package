
import 'package:research_package/model.dart';

RPActivityStep tappingStep = RPTappingActivity("ID");

RPActivityStep activityStepTrail = RPTrailMakingActivity("ID");

RPActivityStep activityStepLetterTapping = RPLetterTappingActivity("ID");

RPActivityStep reactionTimeStep = RPReactionTimeActivity("ID");

RPActivityStep rapidVisualInfoProcessingStep = RPRapidVisualInfoProcessingActivity("ID");

RPActivityStep pairedAssociatesLearningStep = RPPairedAssociatesLearningActivity("ID");

RPActivityStep corsiBlockTapping = RPCorsiBlockTappingActivity("ID");

RPActivityStep stroopEffect = RPStroopEffectActivity("ID");

RPIntegerAnswerFormat minutesIntegerAnswerFormat =
    RPIntegerAnswerFormat.withParams(0, 10000, "minutes");

RPImageChoiceAnswerFormat imageChoiceAnswerFormat =
    RPImageChoiceAnswerFormat.withParams(images);

RPQuestionStep timeOfDayQuestionStep = RPQuestionStep.withAnswerFormat(
    'timeOfDayQuestionStepID', 'When did you wake up?', timeOfDayAnswerFormat);
RPQuestionStep dateAndTimeQuestionStep = RPQuestionStep.withAnswerFormat(
    'dateAndTimeQuestionStepID',
    'When did you last eat unhealthy food?',
    dateAndTimeAnswerFormat);
RPQuestionStep dateQuestionStep = RPQuestionStep.withAnswerFormat(
    'dateQuestionStepID', 'When did you last drink alcohol?', dateAnswerFormat);

// Slider
RPQuestionStep sliderQuestionStep = RPQuestionStep.withAnswerFormat(
    "sliderQuestionsStepID",
    "What did you pay for insulin?",
    sliderAnswerFormat);

RPQuestionStep singleChoiceQuestionStep = RPQuestionStep.withAnswerFormat(
  "questionStep1ID",
  "I have felt cheerful and in good spirits",
  timeAnswerFormat,
);

RPQuestionStep instrumentChoiceQuestionStep = RPQuestionStep.withAnswerFormat(
    "instrumentChoiceQuestionStepID",
    "Which instrument are you playing?",
    instrumentsAnswerFormat);

RPQuestionStep happinessChoiceQuestionStep = RPQuestionStep.withAnswerFormat(
    "happinessChoiceQuestionStepID",
    "What makes you happy?",
    joyfulActivitiesAnswerFormat);

RPQuestionStep weightQuestionStep = RPQuestionStep.withAnswerFormat(
    "weightQuestionStepID", "What is your weight?", weightIntegerAnswerFormat);

RPQuestionStep minutesQuestionStep = RPQuestionStep.withAnswerFormat(
    "minutesQuestionStepID",
    "How many minutes do you spend practicing a week?",
    minutesIntegerAnswerFormat);

RPQuestionStep imageChoiceQuestionStep = RPQuestionStep.withAnswerFormat(
  "imageStepID",
  "Indicate you mood by selecting a picture!",
  imageChoiceAnswerFormat,
);

RPFormStep formStep = RPFormStep.withTitle(
    "formstepID",
    [instrumentChoiceQuestionStep, minutesQuestionStep],
    "Questions about music");

RPCompletionStep completionStep = RPCompletionStep("completionID")
  ..title = "Finished"
  ..text = "Thank you for filling out the survey!";

/* RPTappingAnswerFormat tappingAnswerFormat = RPTappingAnswerFormat.withParams();

RPTrailMakingAnswerFormat trailMakingAnswerFormat =
    RPTrailMakingAnswerFormat.withParams();

RPLetterTappingAnswerFormat letterTappingAnswerFormat =
    RPLetterTappingAnswerFormat.withParams();

RPActivityStep tappingStep = RPActivityStep.withAnswerFormat(
    'activity step ID', 'Title', tappingAnswerFormat);

RPReactionTimeAnswerFormat reactionTimeAnswerFormat =
    RPReactionTimeAnswerFormat.withParams();

RPActivityStep reactionTimeStep = RPActivityStep.withAnswerFormat(
    'activity step ID', 'Title', reactionTimeAnswerFormat);

RPRapidVisualInfoProcessingAnswerFormat rapidVisualInfoProcessingAnswerFormat =
    RPRapidVisualInfoProcessingAnswerFormat.withParams();

RPActivityStep rapidVisualInfoProcessingStep = RPActivityStep.withAnswerFormat(
    'activity step ID', 'Title', rapidVisualInfoProcessingAnswerFormat);

RPActivityStep activityStepTrail = RPActivityStep.withAnswerFormat(
    'identifier', 'title', trailMakingAnswerFormat);

RPActivityStep activityStepLetterTapping = RPActivityStep.withAnswerFormat(
    'identifier', 'title', letterTappingAnswerFormat);

RPPairedAssociatesLearningAnswerFormat pairedAssociatesLearningAnswerFormat =
    RPPairedAssociatesLearningAnswerFormat.withParams();

RPActivityStep pairedAssociatesLearningStep = RPActivityStep.withAnswerFormat(
    'activity step ID', 'Title', pairedAssociatesLearningAnswerFormat);

RPCorsiBlockTappingAnswerFormat corsiBlockTappingAnswerFormat =
    RPCorsiBlockTappingAnswerFormat.withParams();

RPActivityStep corsiBlockTapping = RPActivityStep.withAnswerFormat(
    'identifier', 'title', corsiBlockTappingAnswerFormat);

RPStroopEffectAnswerFormat stroopEffectAnswerFormat =
    RPStroopEffectAnswerFormat.withParams();

RPActivityStep stroopEffect = RPActivityStep.withAnswerFormat(
    'identifier', 'title', stroopEffectAnswerFormat);
 */

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
    stroopEffect,
    corsiBlockTapping,
    pairedAssociatesLearningStep,
    activityStepTrail,
    rapidVisualInfoProcessingStep,
    reactionTimeStep,
    activityStepLetterTapping,
    tappingStep,
  ],
);
