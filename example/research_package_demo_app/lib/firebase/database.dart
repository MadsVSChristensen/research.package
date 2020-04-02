import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final String palResults;
  final String corsiResults;
  final String rvipResults;
  final String tappingResults;
  final String trailResults;
  final String stroopResults;
  final String reactionResults;
  final String letterAResults;

  DBService(
      {this.palResults,
      this.corsiResults,
      this.rvipResults,
      this.letterAResults,
      this.trailResults,
      this.tappingResults,
      this.stroopResults,
      this.reactionResults});

  final CollectionReference testResultCollection =
      Firestore.instance.collection('Test data');

  Future updatePALData(Map results) async {
    return await testResultCollection.document(palResults).setData({
      'PAL test results': results,
    });
  }
}
