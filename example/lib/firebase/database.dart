import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

//methods for updating test data for each test type in the same collection (database).
//U sing Google Firebase.

class DBService {
  final String testResults;

  DBService({
    this.testResults,
  });

  final CollectionReference testResultCollection =
      Firestore.instance.collection('Test data');

  final CollectionReference betaResultCollection =
      Firestore.instance.collection('Beta-results');

  Future updateDBData(String results) async {
    // Saved variables
    SharedPreferences sp = await SharedPreferences.getInstance();
    String id = sp.getString('ID');
    int attempt = sp.getInt('attempts');
    int age = sp.getInt('age');
    String gender = sp.getString('gender');

    return await testResultCollection
        .document('$id-$attempt')
        .setData({'test results': results, 'age': age, 'gender': gender});
//    return await betaResultCollection
//        .document('$id-$attempt')
//        .setData({'test results': results, 'age': age, 'gender': gender});
  }
}
