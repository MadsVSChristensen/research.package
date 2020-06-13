---
layout: single
title: Create Cognitive Tests
permalink: /create-cognitive-tests
toc: true
---

> _This expands upon the ["Creating a Survey"](/survey) tutorial, as this is an extension that mimics and relies on many of the survey functionalities. See ["Cognitive Tests"](/cognitive-tests) for a detailed explanation of each test, including how they are implemented, limitations, measurement types and other useful information._

## Updated Domain Model

### New Step - The ActivityStep

The cognitive tests are a new type of `Step` called the `ActivityStep`. The new `ActivitySteps` can be used in `RPTasks`, where they can be combined with all the other `Step` types (InstructionStep, QuestionStep, CompletionStep etc.). This allows you to create your own instructions for tests, combine them with questions or any other use case you desire.

`ActivitySteps` implement 3 stages of each test - Instruction, Task, Result - which control the flow of the test. `RPActivitySteps` include optional parameters for including or excluding the instruction and the result respectively. Each individual test has additional optional parameters, which can be used for customising the tests better - these can be seen in the ["Cognitive Tests"](/cognitive-tests) section.

### The New Steps

With the congitive tests comes **8** new `RPActivtyStep` models. The `Steps` that are currently available, and the name of their respective test, can be seen below:

- RPCorsiBlockTappingActivity
- RPLetterTappingActivity
- RPPairedAssociatesLearningActivity
- RPRapidVisualInfoProcessingActivity
- RPReactionTimeActivity
- RPStroopEffectActivity
- RPTappingActivity
- RPTrailMakingActivity

Details about the tests can be found in the ["About the Cognitive Tests"](/cognitive-tests#about-the-cognitive-tests) section.

## Example Cognition Test

Below is an example of how to create a test. The example is of the Rapid Visal Information Processing Test, and we have selected the length of the test to be shortened to 30 seconds and excluding the result section of the test.

### Rapid Visual Information Processing Test Example

Creating the `ActivityStep` is very similar to creating a survey question

```dart
RPActivityStep rvipStep = RPRapidVisualInfoProcessing(
	'Rapid Visual Information Processing Test ID',
	lengthOfTest = 30,
	includeResults = false,
);
```

The test can then simply be put inside an `RPTask` in the same way questions can.

```dart
RPOrderedTask task = RPOrderedTask(
	'Cognitive Test Task ID',
	[
		rvipStep,
	]
);
```

Once the `Task` is used in a `RPUITask`, it recognises the `ActivitySteps` and will display the UI of the test - here an `RPUIActivityStep` with a body of `RPUIRapidVisualInfoProcessingActivityBody`.
