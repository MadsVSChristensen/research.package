---
layout: single
title: Create Cognitive Tests
permalink: /create-cognitive-tests
toc: true
---

> _This expands upon the ["Creating a Survey"](/survey) tutorial, as this is an extension._

## Updated Domain Model

### New Step - ActivityStep

The cognitive tests are a new type of `Step` called the `ActivityStep`. The new `ActivityStep` is an extension of the `RPStep`.

A congitive test battery is created the same way you create a survey. The cognitive tests are part of the new type of `Step` available to be used in a `RPTask`. They can be coupled with all the other `Step`s in a parent `RPTask` if needed.

### New Answer Formats

With the congitive tests comes **8** new types of `AnswerFormat`s. The...

At the time of writing, the `AnswerFormat`s are for the `Step` to recognize the type. As new tests can have different version, this will change and the `AnswerFormat`s will take arguments to adapt the test results.

`FormStep` is not applicable with cognitive tests as they required the full screen to work optimally. Currently, this will cause errors at runtime.

To see all the possible cognitive tests please see the [list of available answer formats](/answer-formats).

## Example Cognition Test

### Rapid Visual Information Processing

Creating the `AnswerFormat` is very similar to surveys, as seen below.

**IMAGE**
