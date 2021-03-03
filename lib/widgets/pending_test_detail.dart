import 'package:flutter/material.dart';

import '../services/database.dart';

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
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'Test Category: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['test_category'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'Created On: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['created_on'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'Created By: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Emp 1',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
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
