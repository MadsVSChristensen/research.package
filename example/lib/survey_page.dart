import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';

import 'firebase/database.dart';
import 'research_package_objects/survey_objects.dart';

class SurveyPage extends StatelessWidget {
  String _encode(Object object) => const JsonEncoder.withIndent(' ').convert(object);

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  void resultCallback(RPTaskResult result) async {
    printWrapped(_encode(result));
    print(result.results['Trail Making step ID']);
    print((result.results['Trail Making step ID'] as RPActivityResult).results);
    print((result.results['Trail Making step ID'] as RPActivityResult).stepTimes.toJson());
    print((result.results['Trail Making step ID'] as RPActivityResult).interactions.toString());

    // await DBService().updateDBData(_encode(result.results));
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: surveyTask,
      onSubmit: (result) {
        resultCallback(result);
      },
    );
  }
}
