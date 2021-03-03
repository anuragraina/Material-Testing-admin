import 'package:flutter/material.dart';

import '../../widgets/test_type.dart';
import '../../services/auth.dart';

class MainHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
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
            TestType(name: 'Test Analysis', route: '/test-analysis'),
            TestType(name: 'Manage Users', route: '/manage-users'),
            TestType(name: 'Manage Sites', route: '/manage-sites'),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
