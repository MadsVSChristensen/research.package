import 'package:research_package/model.dart';

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
    pairedAssociatesLearningStep,
    tappingStep,
    activityStepTrail,
    corsiBlockTapping,
    rapidVisualInfoProcessingStep,
    stroopEffect, 
    reactionTimeStep,
    completionStep,
    activityStepLetterTapping,  
  ],
);
