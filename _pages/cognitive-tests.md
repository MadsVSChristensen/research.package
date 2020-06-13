---
layout: single
title: Cognitive Tests
permalink: /cognitive-tests
toc: true
---

_As of June 2020, an expansion by [Mads Vedel Saaby Christensen](https://github.com/MadsVSChristensen), and [Simon Strandly Brandt](https://github.com/s174286) has been added to Research Package, featuring a range of cognitive tests. The tests can be seen below._

## About the cognitive tests

The tests in Research Package are called `ActivitySteps`. They derive from Apple's ResearchKit's Active Tasks, but where transformed to `Steps` instead, so that they may be used inside a `RPTask` along with other types of `Steps`.
Each test consists of **3** key sections - the instructions for the test, the test itself and the results of the test. Results are _not_ interpreted and draws no conclusions as these are elements of the usecase, which may vary considerably.

### Examples of all tests

|                                                    Reaction Time                                                     |                                                    Trail Making                                                     |                                                 Letter Tapping                                                  |
| :------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------: |
| ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/ReactionTime.gif) | ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/TrailMaking.gif) | ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/LetterA.gif) |

|                                         Paired Associates Learning                                          |                                                  Tapping Speed                                                  |                                              Corsi Block Tapping                                              |
| :---------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------: |
| ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/PAL.gif) | ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/Tapping.gif) | ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/Corsi.gif) |

|                                                 Stroop Effect                                                  |                                     Rapid Visual Information Processing                                      |     |
| :------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :-: |
| ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/Stroop.gif) | ![](https://raw.githubusercontent.com/MadsVSChristensen/research.package/master/documentation/gifs/RVIP.gif) |     |

## Tests

Here you find information about the cognitive areas each test covers, as well as all the customisation options for each test.

### Corsi Block Tapping Test

Testing Area:\\
The Corsi Block Tapping Test covers and assesses **spatial processing**, **visual processing** and **working memory**.

Optional Parameters:

| Parameter           | description                                                    |
| ------------------- | -------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default. |
| includeResults      | If `false` then results are not shown. `true` as default.      |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Correctly repeating the highlighted tiles - correct gesture, log number of attempts and the tapped order.
- Failing to repeat highlighted tiles first time - incorrect gesture, log the incorrect input and the correct order.
- Failing test by tapping wrong order of tiles second time - incorrect gesture, log the incorrect user input and the correct order.

### Letter A Tapping Test

Testing Area:\\
The Letter A Tapping Test covers and assesses **auditory processing** and **sustained attention**.

Optional Parameters:

| Parameter           | description                                                    |
| ------------------- | -------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default. |
| includeResults      | If `false` then results are not shown. `true` as default.      |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Tapping button at letter "a" - correct gesture, log letter list, marking the correct "a".
- Tapping with delay at letter "a" - correct gesture, log letter list, marking the correct "a".
- Tapping multiple times at letter "a" - correct gesture, log letter list, marking the correct "a".
- No Button tap at an "a" - incorrect gesture, log letter list, marking the missed "a".
- Tapping at a wrong letter - incorrect gesture, log letter list, marking the incorrectly tapped letter.

### Paired Associates Learning Test

Testing Area:\\
The Paired Associates Learning Test covers and assesses **working memory** and **visual processing**.

Optional Parameters:

| Parameter           | description                                                    |
| ------------------- | -------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default. |
| includeResults      | If `false` then results are not shown. `true` as default.      |
| maxTestDuration     | Maximum duration of the test. 100 secounds as default          |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Tapping tile matching middle object - correct gesture, log current difficulty and the tapped tile.
- Tapping tile not matching middle object - incorrect gesture, log current difficulty and the tapped tile.

### Rapid Visual Information Processing Test

Testing Area:\\
The Rapid Visual Information Processing Test covers and assesses **sustained attention**, **processing speed**, **working memory** and **visual processing**.

Optional Parameters:

| Parameter           | description                                                    |
| ------------------- | -------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default. |
| includeResults      | If `false` then results are not shown. `true` as default.      |
| interval            | Highest number to choose. E.g. 5 is (0 - 5). 9 as default      |
| lenghtOfTest        | Duration of test. 90 seconds as default                        |
| sequence            | Sequence of numbers that the testee must keep track of         |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Tapping button after sequence appeared - correct gesture, log amount of sequences passed, delay time on tap and the total sequence of numbers displayed.
- Tapping when sequence has not appeared - incorrect gesture, log amount of sequences passed and the total sequence of numbers displayed.

### Reaction Time Test

Testing Area:\\
The Reaction Time Test covers and assesses **psycho-motor speed**, **processing speed**, **visual processing** and **sustained attention**.

Optional Parameters:

| Parameter           | description                                                                          |
| ------------------- | ------------------------------------------------------------------------------------ |
| includeInstructions | If `false` then instructions are not shown. `true` as default.                       |
| includeResults      | If `false` then results are not shown. `true` as default.                            |
| lengthOfTest        | Duration of test. 30 seconds as default.                                             |
| switchInterval      | Max seconds passed before triggerering the reaction (switch to green). 4 as default. |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Tapping screen when green - correct gesture, log amount of time passed since screen turned green.
- Tapping screen when red - incorrect gesture, log that the screen was pressed prematurely.

### Stroop Effect Test

Testing Area:\\
The Stroop Effect Test covers and assesses **visual processing**, **processing speed** and **selective attention**.

Optional Parameters:

| Parameter           | description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default.            |
| includeResults      | If `false` then results are not shown. `true` as default.                 |
| lenghtOfTest        | Duration of test. 30 seconds as default.                                  |
| displayTime         | Amount of time each word is displayed in milliseconds. 1000ms as default. |
| delayTime           | Amount of time between words in milliseconds. 750ms as default.           |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Tapping correct color word - correct gesture, log the color of the displayed word and what it spelled, along with total amount of words displayed.
- Tapping incorrect color word - incorrect gesture, log the tapped color, what color should have been tapped, what the displayed word spelled and the total amount of words displayed.
- No color word tapped in time - incorrect gesture, log what the word spelled, its color and total amount of words passed.

### Finger Tapping Test

Testing Area:\\
The Finger Tapping Test covers and assesses **sensory-motor skills**.

Optional Parameters:

| Parameter           | description                                                    |
| ------------------- | -------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default. |
| includeResults      | If `false` then results are not shown. `true` as default.      |
| lenghtOfTest        | Duration of test. 30 seconds as default.                       |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Tapping a button - correct gesture, log if left or right button was tapped.

### Trail Making Test

Testing Area:\\
The Trail Making Test covers and assesses **spatial processing**, **logic / reasoning** and **visual processing**.

Optional Parameters:

| Parameter           | description                                                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| includeInstructions | If `false` then instructions are not shown. `true` as default.                                                            |
| includeResults      | If `false` then results are not shown. `true` as default.                                                                 |
| trailType           | `TrailType.A` shows only numbers, while `TrailType.B` interchanges between numbers and letters. `TrailType.A` as default. |

Logged Information:

- Times of each stage (Start and end of Instruction, Task, Result)
- Correctly draw a path between two blocks - correct gesture, log start and end block of drawing.
- Start drawing from correct block to a wrong one - incorrect gesture, log which block was incorrectly hit and what the correct one was.
- Drawing a path which has wrong starting point - incorrect gesture, log which block should have been the starting point.
- Drawing a path which has wrong end point - incorrect gesture, log which block would have been the correct end point.

## Implementing your own test

To implement a test, only two classes must be created - a model for the test and the UI of the test.
As an example a test will be created along the way.

1. Create a model that follows the RP name scheme - this could be RPLineDrawingActivity.
   - Give it a constructor with ID
   - Optionally: include variables of your own. `includeInstructions` and `includeResults` can also be used.
2. Create the UI with the body of the test in a Widget - this could be RPUILineDrawingActivityBody.
   - In the widget constructor 3 things are recommended: - The activity model to include any variables you may use. - The `RPActivityEventLogger` to log any additional information of interactions by the user. E.g. "User pressed button too many times. Pressed 8 times." - An `onResultChange` function to send the result to be stored.
   - In the build function create the UI however you see fit. We recommend implementing Instructions, Test and Result UI's.
3. In `RPUIActivityStep` add your new test as a case in the `stepBody` function.

Done! You have now created your own test (or activity).

## Gesture Logging

Each RPUI-Activity is equipped with an `RPActivityGestureLogger`, which tracks a select, key events during a test. Above, in the "Tests" section you can see all _additional information_ logged for each test. The `RPActivityGestureLogger` has functions to store interactions such as `addCorrectGesture` and functions to store section changes in the test - e.g. Going from Instruction to Test section. See the examples in "Tests" for inspiration about what to log.

## Limitations

`FormStep` is not applicable with cognitive tests as they required the full screen to work optimally. Currently, this will cause errors at runtime.

`RPNavigableOrderedTask` does not currently function with the cognitive tests.
