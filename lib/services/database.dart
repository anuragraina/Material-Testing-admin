import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference _newTests = FirebaseFirestore.instance.collection('newTests');

  Stream getPendingRecords() {
    return _newTests.snapshots();
  }
}
