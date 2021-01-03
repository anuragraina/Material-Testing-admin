import 'package:flutter/material.dart';

import '../../widgets/test_type.dart';
import '../../services/auth.dart';

class ManageUsers extends StatelessWidget {
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
            TestType(name: 'Add User', route: '/add-user'),
            TestType(name: 'Update User', route: '/update-user'),
            TestType(name: 'Delete User', route: '/delete-user'),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
