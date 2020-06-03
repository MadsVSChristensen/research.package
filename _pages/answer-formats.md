---
layout: single
title: Answer Formats
permalink: /answer-formats
toc: true
---

## Answer Formats

Answer formats are defined by the [`RPAnswerFormat`](https://pub.dev/documentation/research_package/latest/research_package_model/RPAnswerFormat-class.html) class.

Below is a UI representation of the currently available answer formats of Research Package at the moment.

| <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/SingleChoiceAnswerFormat.png">  |    <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/MultipleChoiceAnswerFormat.png">    |      <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/IntegerAnswerFormat.png">       |
| :-----------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                   Single Choice                                                                   |                                                                     Multiple Choice                                                                      |                                                                        Integer                                                                         |
| <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/DateTimeAnswerFormat_Date.png"> | <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/DateTimeAnswerFormat_DateAndTime.png"> | <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/DateTimeAnswerFormat_TimeOfDay.png"> |
|                                                         Date and Time (Date Answer Style)                                                         |                                                        Date and Time (Date and Time Answer Style)                                                        |                                                        Date and Time (Time of Day Answer Style)                                                        |
|  <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/ImageChoiceAnswerFormat.png">  |        <img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/SliderAnswerFormat.png">        |                                                                                                                                                        |
|                                                                   Image Choice                                                                    |                                                                          Slider                                                                          |                                                                                                                                                        |

## Form Step

Furthermore it is possible to put multiple questions on the same page by using a form step - [`RPFormStep`](https://pub.dev/documentation/research_package/latest/research_package_model/RPFormStep-class.html).
Each question step have a separate card, which is shown below.

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/FormAnswerFormat.png" width="300">
