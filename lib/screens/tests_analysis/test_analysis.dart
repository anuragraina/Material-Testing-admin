//Change the folder name

import 'package:flutter/material.dart';

import '../../widgets/test_type.dart';
import '../../services/auth.dart';

class TestAnalysis extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Analysis'),
        actions: <Widget>[
          FlatButton.icon(
            textColor: Colors.white,
            onPressed: () async {
              await _auth.logOut();
            },
            icon: Icon(Icons.person),
            label: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TestType(name: 'Pending Tests', route: '/pending-tests/users'),
            TestType(name: 'Approved Tests', route: '/approved-tests/users'),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
