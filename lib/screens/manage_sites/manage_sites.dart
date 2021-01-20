//CHange the folder name

import 'package:flutter/material.dart';

import '../../widgets/test_type.dart';
import '../../services/auth.dart';

class ManageSites extends StatelessWidget {
  final AuthService _auth = AuthService();

  void addSite(ctx) {
    showModalBottomSheet(
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return Container(child: Text('hello'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Sites'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => addSite(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
