import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';
import './pending_test_detail.dart';

class PendingTests extends StatelessWidget {
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final userUid = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Tests'),
      ),
      body: StreamBuilder(
        stream: _db.getPendingTests(userUid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data.docs.isEmpty) {
            return Center(child: Text('No pending tests available'));
          }

          return Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: snapshot.data.docs.map<Widget>((document) {
                final data = document.data();
                final createdOn =
                    DateTime.fromMicrosecondsSinceEpoch(data['created_on'].microsecondsSinceEpoch);
                final dateOfReceipt = DateTime.fromMicrosecondsSinceEpoch(
                    data['date_of_receipt'].microsecondsSinceEpoch);
                final dateOfTesting = DateTime.fromMicrosecondsSinceEpoch(
                    data['date_of_testing'].microsecondsSinceEpoch);

                data['created_on'] = DateFormat('d MMM, yyyy – hh:mm aaa').format(createdOn);
                data['date_of_receipt'] = DateFormat('d MMM, yyyy').format(dateOfReceipt);
                data['date_of_testing'] = DateFormat('d MMM, yyyy').format(dateOfTesting);

                return Card(
                  child: ListTile(
                    title: Text(data['test_name']),
                    subtitle: Text(data['test_category']),
                    trailing: Text(
                      data['created_on'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onTap: () => modalBottomSheet(context, {'id': document.id, ...data}, userUid),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                );
              }).toList(),
            ),
          );
        },
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
