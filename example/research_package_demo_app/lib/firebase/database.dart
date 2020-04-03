import 'package:cloud_firestore/cloud_firestore.dart';
//methods for updating test data for each test type in the same collection (database).
//U sing Google Firebase.


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

  Future updatePALData(String results) async {
    return await testResultCollection.document(palResults).setData({
      'PAL test results': results,
    });
  }

  Future updateCorsiData(Map results) async {
    return await testResultCollection.document(corsiResults).setData({
      'Corsi test results': results,
    });
  }

  Future updateRVIPData(Map results) async {
    return await testResultCollection.document(rvipResults).setData({
      'RVIP test results': results,
    });
  }

  Future updateLetterAData(Map results) async {
    return await testResultCollection.document(letterAResults).setData({
      'Letter A test results': results,
    });
  }

  Future updateTappingData(Map results) async {
    return await testResultCollection.document(tappingResults).setData({
      'tapping test results': results,
    });
  }

  Future updateStoopData(Map results) async {
    return await testResultCollection.document(stroopResults).setData({
      'Stoop test results': results,
    });
  }

  Future updateReactionData(Map results) async {
    return await testResultCollection.document(reactionResults).setData({
      'Reaction test results': results,
    });
  }
}
