import 'package:cloud_firestore/cloud_firestore.dart';
import './auth.dart';

class DatabaseService {
  final AuthService _auth = AuthService();
  final CollectionReference _newTests = FirebaseFirestore.instance.collection('newTests');
  final CollectionReference _approvedTests = FirebaseFirestore.instance.collection('approvedTests');

  Stream getPendingRecords() {
    return _newTests.snapshots();
  }

  Stream getApprovedRecords() {
    return _approvedTests.snapshots();
  }

  //respond if addition was successful or not
  void addTest(Map data) async {
    try {
      var user = _auth.currentUser();
      DocumentReference addResult = await _approvedTests.add({
        'approved_by': user,
        'approved_on': FieldValue.serverTimestamp(),
        ...data,
      });
      print(addResult);
      await _newTests.doc(data['id']).delete();
      print('deleted');
    } catch (e) {
      print(e.toString());
    }
  }
}
