
import 'package:research_package/model.dart';

RPActivityStep tappingStep = RPTappingActivity("ID");

RPActivityStep activityStepTrail = RPTrailMakingActivity("ID");

RPActivityStep activityStepLetterTapping = RPLetterTappingActivity("ID");

RPActivityStep reactionTimeStep = RPReactionTimeActivity("ID");

RPActivityStep rapidVisualInfoProcessingStep = RPRapidVisualInfoProcessingActivity("ID");

RPActivityStep pairedAssociatesLearningStep = RPPairedAssociatesLearningActivity("ID");

RPActivityStep corsiBlockTapping = RPCorsiBlockTappingActivity("ID");

RPActivityStep stroopEffect = RPStroopEffectActivity("ID");

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
