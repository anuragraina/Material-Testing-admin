import 'package:cloud_firestore/cloud_firestore.dart';
import './auth.dart';

class DatabaseService {
  final AuthService _auth = AuthService();
  final CollectionReference _sites = FirebaseFirestore.instance.collection('sites');

  Stream getSites() {
    return _sites.snapshots();
  }

  void deleteSite(String id) async {
    await _sites.doc(id).delete();
    print('Site Deleted');
  }

  //respond if addition was successful or not
  void approveTest(Map data, String userUid) async {
    final CollectionReference pendingTests =
        FirebaseFirestore.instance.collection('users').doc(userUid).collection('new_tests');
    final CollectionReference approvedTests =
        FirebaseFirestore.instance.collection('users').doc(userUid).collection('approved_tests');
    try {
      var user = _auth.currentUser();
      DocumentReference addResult = await approvedTests.add({
        'approved_by': user,
        'approved_on': FieldValue.serverTimestamp(),
        ...data,
      });
      print(addResult);
      await pendingTests.doc(data['id']).delete();
      print('deleted');
    } catch (e) {
      print(e.toString());
    }
  }

  void rejectTest(Map data, String userUid) async {
    final CollectionReference pendingTests =
        FirebaseFirestore.instance.collection('users').doc(userUid).collection('new_tests');

    try {
      await pendingTests.doc(data['id']).delete();
      print('deleted');
    } catch (e) {
      print(e.toString());
    }
  }

  Future addSite(String name, String location) async {
    try {
      DocumentReference addResult = await _sites.add({'site_name': name, 'location': location});
      print(addResult);
      return addResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream getPendingTests(String uid) {
    final CollectionReference pendingTests =
        FirebaseFirestore.instance.collection('users').doc(uid).collection('new_tests');

    return pendingTests.snapshots();
  }

  Stream getApprovedTests(String uid) {
    final CollectionReference pendingTests =
        FirebaseFirestore.instance.collection('users').doc(uid).collection('approved_tests');

    return pendingTests.snapshots();
  }
}
