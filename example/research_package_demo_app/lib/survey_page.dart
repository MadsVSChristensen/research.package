import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'research_package_objects/survey_objects.dart';
import 'dart:convert';
import 'firebase/database.dart';

class SurveyPage extends StatelessWidget {
  String _encode(Object object) => const JsonEncoder.withIndent(' ').convert(object);

  void resultCallback(RPTaskResult result) async {
    // Do anything with the result
    print(_encode(result.results));
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
