//CHange the folder name

import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../services/auth.dart';
// import '../../widgets/test_type.dart';
import '../../services/database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../widgets/delete_site_confirmation.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();

  String name = '';
  String location = '';

  void addSite(ctx) {
    ProgressDialog pr = ProgressDialog(ctx);
    pr = ProgressDialog(
      ctx,
      type: ProgressDialogType.Normal,
      isDismissible: true,

      /// your body here
      customBody: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );

    showModalBottomSheet(
        context: ctx,
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Form(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Container(
                          width: 325,
                          child: TextFormField(
                            // autofocus: true,
                            onChanged: (value) {
                              setState(() => name = value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter site name',
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: 325,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() => location = value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter location',
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Add Site',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () async {
                            await pr.show();
                            dynamic result = await _db.addSite(name, location);
                            print(result);
                            await pr.hide();
                            Navigator.of(context).pop();
                            setState(() => name = '');
                            setState(() => location = '');
                            // if (result == null) {
                            //   //Create Alertbox
                            //   showAlertDialog(context);
                            // }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

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
                  // final time =
                  //     DateTime.fromMicrosecondsSinceEpoch(data['approved_on'].microsecondsSinceEpoch);

                  // data['approved_on'] = DateFormat('d MMM, yyyy – hh:mm aaa').format(time);

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
          onPressed: () async {
            HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createUser');

            await callable({'name': 'sas'});
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
