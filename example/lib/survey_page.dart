import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'research_package_objects/survey_objects.dart';
import 'dart:convert';
import 'firebase/database.dart';

class SurveyPage extends StatelessWidget {
  String _encode(Object object) => const JsonEncoder.withIndent(' ').convert(object);

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  void resultCallback(RPTaskResult result) async {
    print(result.results);
    print(result.results.values);
    print((result.results.values.first as RPActivityResult).results);
    print((result.results.values.first as RPActivityResult).stepTimes);
    print((result.results.values.first as RPActivityResult).interactions);
    print(result.results.values.first.toJson());
    // Do anything with the result
//     print(_encode(result.results));
    printWrapped(_encode(result.results));
    await DBService().updatePALData(_encode(result.results));
    //make sure in future not to save empty results. 
  }

  @override
  Widget build(BuildContext context) {
    return RPUIOrderedTask(
      task: surveyTask,
      onSubmit: (result) {
        resultCallback(result);
      },
    );
  }
}
