// ignore: todo
//TODO - Add update & delete functionality

import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/users.dart';
import './add_user.dart';
import './delete_user_confirmation.dart';

class ManageUsers extends StatelessWidget {
  final AuthService _auth = AuthService();
  final UserService _user = UserService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Users'),
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
        body: FutureBuilder(
          future: _user.getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: snapshot.data.map<Widget>((user) {
                  return Card(
                    child: ListTile(
                      title: user['name'] == null ? Text('Not defined') : Text(user['name']),
                      subtitle: Text(user['email']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => showAlertDeleteUser(context, user['uid']),
                        color: Colors.red,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  );
                }).toList(),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: AddUser(),
                );
              }),
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
