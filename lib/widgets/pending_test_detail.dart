import 'package:flutter/material.dart';

void modalBottomSheet(BuildContext context, Map data) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 350,
          child: Column(
            children: [
              Text(
                data['test_name'],
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
                      data['created_by'],
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Table(
              //   border: TableBorder.all(),
              //   children: [
              //     for (var property in data.values)
              //       TableRow(children: [
              //         TableCell(
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: <Widget>[
              //               new Text(property),
              //               new Text('c'),
              //             ],
              //           ),
              //         )
              //       ])
              //   ],
              // ),
            ],
          ),
        );
      });
}
