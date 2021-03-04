import 'package:flutter/material.dart';

import '../../services/database.dart';
import '../../widgets/test_detail.dart';

void modalBottomSheet(BuildContext context, Map data, String userUid) {
  final DatabaseService _db = DatabaseService();

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
              if (data['test_name'] != 'Gradation')
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
                )
              else
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'IS Sieve Size',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Weight Retained (gm)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Cumulative Wt. Retained (gm)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Cumulative % Wt. Retained',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Cumulative % Wt. Passing',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ]),
                    for (var item in data['values']['data'].keys)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                item.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          for (var detail in data['values']['data'][item].keys)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                      data['values']['data'][item][detail].toStringAsFixed(3))),
                            ),
                        ],
                      ),
                  ],
                ),
              if (data['test_name'] == 'Gradation')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Fineness Modulus : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(data['values']['fineness_modulus'].toStringAsFixed(3))
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        child: Text('Reject'),
                        onPressed: () {
                          _db.rejectTest(data, userUid);
                          Navigator.of(context).pop();
                        }),
                    RaisedButton(
                      child: Text('Approve'),
                      onPressed: () {
                        _db.approveTest(data, userUid);
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
