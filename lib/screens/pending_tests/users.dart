import 'package:flutter/material.dart';

import '../../services/users.dart';

class PendingTestUserList extends StatelessWidget {
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
          title: Text('Users with pending tests'),
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
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  );
                }).toList(),
              ),
            );
          },
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
