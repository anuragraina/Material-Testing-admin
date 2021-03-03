import 'package:flutter/material.dart';

import '../services/database.dart';
import '../widgets/test_detail.dart';

void modalBottomSheet(BuildContext context, Map data, String userUid) {
  final DatabaseService _database = DatabaseService();

  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Text(
                data['test_name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TestDetail('Test Category: ', data['test_category']),
              TestDetail('Created On: ', data['created_on']),
              TestDetail('Site: ', data['site']),
              TestDetail('Sample Source: ', data['sample_source']),
              TestDetail('Sample UID: ', data['sample_uid']),
              TestDetail('Date of receipt: ', data['date_of_receipt']),
              TestDetail('Date of testing: ', data['date_of_testing']),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Values',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Table(
                border: TableBorder.all(),
                children: [
                  for (var item in data['values'].keys)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(item.toString())),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(data['values'][item].toString())),
                        ),
                      ],
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    RaisedButton(
                      child: Text('Approve'),
                      onPressed: () {
                        _database.addTest(data, userUid);
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
}
