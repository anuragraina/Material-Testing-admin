import 'package:flutter/material.dart';

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
            return Text("Loading");
          }

          return Padding(
            padding: EdgeInsets.all(10),
            child: new ListView(
              children: snapshot.data.documents.map<Widget>((document) {
                return new Card(
                  child: new ListTile(
                    title: new Text(document.data()['test_name']),
                    subtitle: new Text(document.data()['test_category']),
                    trailing: new Text(DateTime.fromMicrosecondsSinceEpoch(
                            document.data()['created_on'].microsecondsSinceEpoch)
                        .toString()),
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
