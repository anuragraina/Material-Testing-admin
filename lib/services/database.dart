import 'package:cloud_firestore/cloud_firestore.dart';
import './auth.dart';

class DatabaseService {
  final AuthService _auth = AuthService();
  final CollectionReference _newTests = FirebaseFirestore.instance.collection('newTests');

  Future addTest({
    String testCategory,
    String testName,
    Map values,
  }) async {
    try {
      var user = _auth.currentUser();
      DocumentReference result = await _newTests.add({
        'created_by': user,
        'created_on': FieldValue.serverTimestamp(),
        'test_category': testCategory,
        'test_name': testName,
        'values': values,
      });
      print(result);
    } catch (e) {
      print(e.toString());
    }
  }
}
