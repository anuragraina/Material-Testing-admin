import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';

class PendingTests extends StatelessWidget {
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Tests'),
      ),
      body: StreamBuilder(
        stream: _db.getPendingRecords(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          return Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: snapshot.data.documents.map<Widget>((document) {
                DateTime time = DateTime.fromMicrosecondsSinceEpoch(
                    document.data()['created_on'].microsecondsSinceEpoch);

                String formattedTime = DateFormat('d MMM, yyyy – hh:mm aaa').format(time);

                return Card(
                  child: ListTile(
                    title: Text(document.data()['test_name']),
                    subtitle: Text(document.data()['test_category']),
                    trailing: Text(
                      formattedTime,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
