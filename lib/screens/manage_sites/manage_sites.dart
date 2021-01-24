//CHange the folder name

import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/database.dart';
import '../../widgets/delete_site_confirmation.dart';
import './add_site.dart';

class ManageSites extends StatelessWidget {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();

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
        body: StreamBuilder(
          stream: _db.getSites(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: snapshot.data.docs.map<Widget>((document) {
                  final data = document.data();

                  return Card(
                    child: ListTile(
                        title: Text(data['site_name']),
                        subtitle: Text(data['location']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => showAlertDeleteSite(context, document.id),
                          color: Colors.red,
                        )),
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
                  child: AddSite(),
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
